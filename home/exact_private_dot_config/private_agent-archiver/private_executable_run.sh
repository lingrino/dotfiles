#!/usr/bin/env bash
set -euo pipefail

# Durable AWS IAM credentials, rendered from 1Password by chezmoi. These are
# only used to read the application secret below. The application secret itself
# is fetched fresh on every run and is never written to disk.
ENV_FILE="${HOME}/.config/agent-archiver/aws.env"

# AWS Secrets Manager secret holding the archive script's environment as a JSON
# object of key/value pairs.
SECRET_ID="apps/agent-archiver/production"

# The content archive script, synced to the mini via iCloud.
ARCHIVE_SCRIPT="${HOME}/Documents/content/scripts/archive.sh"

if [[ ! -f "${ENV_FILE}" ]]; then
  echo "agent-archiver: ${ENV_FILE} not found." >&2
  exit 1
fi

if [[ ! -f "${ARCHIVE_SCRIPT}" ]]; then
  echo "agent-archiver: ${ARCHIVE_SCRIPT} not found." >&2
  exit 1
fi

# Load the AWS IAM credentials used to read the secret.
set -a
# shellcheck source=/dev/null
source "${ENV_FILE}"
set +a

# Fetch the application environment from Secrets Manager (never persisted).
secret_json="$(aws secretsmanager get-secret-value \
  --secret-id "${SECRET_ID}" \
  --query SecretString \
  --output text)"

if [[ -z "${secret_json}" || "${secret_json}" == "None" ]]; then
  echo "agent-archiver: empty or missing secret '${SECRET_ID}'." >&2
  exit 1
fi

# Export each key/value pair from the secret into the environment. @sh shell-
# quotes every value so spaces and special characters survive intact.
eval "$(printf '%s' "${secret_json}" | jq -r 'to_entries[] | "export \(.key)=\(.value | @sh)"')"
unset secret_json

# Hand off to the archive script with the populated environment.
#
# ~/Documents is TCC-protected, so the headless launchd job needs Full Disk
# Access to read the content tree. TCC keys grants to the interpreter binary's
# path, so everything that touches ~/Documents must run under the SAME granted
# interpreter. We use /bin/bash: a stable, unversioned system path, so the
# one-time FDA grant survives Homebrew upgrades (the brew bash path is
# versioned and would re-break the grant on every bump). archive.sh is
# POSIX/bash-3.2 compatible, so 3.2.57 runs it correctly.
#
# Two places pick the interpreter, and both must land on /bin/bash:
#   1. This exec, for the main process.
#   2. archive.sh re-execs itself per worker via xargs ("$0" --worker), which
#      goes through its own `#!/usr/bin/env bash` shebang. `env bash` honors
#      PATH, so the system dirs must precede Homebrew or the worker resolves to
#      the ungranted brew bash and dies with "Operation not permitted". The
#      only command this reorders is bash itself; agent-archiver/jq/aws are
#      Homebrew-only and still resolve further down PATH.
export PATH="/usr/bin:/bin:/opt/homebrew/bin"
exec /bin/bash "${ARCHIVE_SCRIPT}"
