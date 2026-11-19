#!/usr/bin/env bash
set -euo pipefail

# The 1Password service account token is put in place by hand, so nothing else
# keeps its permissions tight.
TOKEN_FILE="${HOME}/.config/op/service-account-token"
if [[ -f "${TOKEN_FILE}" && "$(/usr/bin/stat -f '%Lp' "${TOKEN_FILE}")" != "600" ]]; then
    chmod 600 "${TOKEN_FILE}"
    echo "checks: set ${TOKEN_FILE} to mode 600"
fi

UNMANAGED=$(chezmoi unmanaged 2>&1)
if [[ -n "${UNMANAGED}" ]]; then
    printf "error: there are unmanaged files:\n%s\n" "${UNMANAGED}"
    exit 1
fi
