#!/usr/bin/env bash
set -euo pipefail

PACKAGES="
@stripe/link-cli
"

for PACKAGE in ${PACKAGES}; do
    OUTPUT=$(bun install --global "${PACKAGE}" 2>&1)
    if [[ ${OUTPUT} == *"packages installed"* ]]; then
        echo "bun: installed ${PACKAGE}"
    fi
done
