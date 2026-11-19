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

# Passed to every command that writes packs (backup and prune). Without it the
# packs that prune rewrites would be stored in the standard storage class.
OPTIONS=(-o s3.storage-class=GLACIER_IR)

# Initialize the repository if it does not exist yet.
if ! restic snapshots --latest 1 >/dev/null 2>&1; then
  echo "restic-backup: initializing repository..."
  restic init
fi

# Back up target directories.
restic "${OPTIONS[@]}" backup \
  "${HOME}/Documents" \
  "${HOME}/Pictures/Photos Library.photoslibrary"

# Apply the retention policy. This only drops snapshots, which is cheap.
restic forget \
  --keep-within-hourly 30d \
  --keep-daily unlimited

# Reclaim the space weekly rather than hourly: prune rewrites packs and holds an
# exclusive lock on the repository while it runs.
PRUNE_STAMP="${HOME}/.cache/restic-backup/last-prune"
if [[ ! -f "${PRUNE_STAMP}" || -n "$(find "${PRUNE_STAMP}" -mtime +6)" ]]; then
  restic "${OPTIONS[@]}" prune
  mkdir -p "$(dirname "${PRUNE_STAMP}")"
  touch "${PRUNE_STAMP}"
fi
