#!/usr/bin/env bash
set -euo pipefail

ENV_FILE="${HOME}/.config/restic/env"

if [[ ! -f "${ENV_FILE}" ]]; then
  echo "restic-backup: ${ENV_FILE} not found." >&2
  exit 1
fi

set -a
# shellcheck source=/dev/null
source "${ENV_FILE}"
set +a

# Initialize the repository if it does not exist yet.
if ! restic snapshots --latest 1 >/dev/null 2>&1; then
  echo "restic-backup: initializing repository..."
  restic init
fi

# Back up target directories.
restic backup \
  -o s3.storage-class=GLACIER_IR \
  "${HOME}/Documents" \
  "${HOME}/Pictures/Photos Library.photoslibrary"

# Apply retention policy and prune.
restic forget \
  --prune \
  --keep-within-hourly 30d \
  --keep-daily unlimited
