#!/usr/bin/env sh
set -euo pipefail

OUTPUT_INIT=$(rustup-init -y --no-modify-path 2>&1)
if [[ ${OUTPUT_INIT} == *"downloading"* ]]; then
    echo "rust: initialized"
fi

OUTPUT_UPDATE=$(rustup update 2>&1)
if [[ ${OUTPUT_UPDATE} == *"updated"* ]]; then
    echo "rust: updated"
fi

OUTPUT_DEFAULT=$(rustup default stable 2>&1)
if [[ ${OUTPUT_DEFAULT} == *"updated"* ]]; then
    echo "rust: default set"
fi
