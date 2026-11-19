#!/usr/bin/env bash
set -euo pipefail

# https://github.com/tailscale/tailscale/wiki/Tailscaled-on-macOS

# Not pgrep: it skips its own ancestors, and over Tailscale SSH tailscaled is
# one. Not `ps | grep -q` either: under pipefail the early exit fails the pipe.
if [[ "$(ps -axo comm=)" != *tailscaled* ]]; then
    sudo tailscaled install-system-daemon
fi

tailscale up --ssh --accept-routes --advertise-exit-node
