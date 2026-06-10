#!/usr/bin/env sh
set -euo pipefail

PACKAGES="
@tobilu/qmd
"

for PACKAGE in ${PACKAGES}; do
    OUTPUT=$(bun install --global "${PACKAGE}" 2>&1)
    if [[ ${OUTPUT} == *"packages installed"* ]]; then
        echo "bun: installed ${PACKAGE}"
    fi
done
