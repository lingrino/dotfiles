#!/usr/bin/env sh
set -euo pipefail

UNMANAGED=$(chezmoi unmanaged 2>&1)
if [[ -n "${UNMANAGED}" ]]; then
    printf "error: there are unmanaged files:\n%s\n" "${UNMANAGED}"
    exit 1
fi
