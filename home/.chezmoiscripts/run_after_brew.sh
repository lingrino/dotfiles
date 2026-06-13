#!/usr/bin/env sh
set -euo pipefail

brew update
brew bundle --global | grep -v 'Using' || true
brew bundle cleanup --global --force --zap
brew upgrade
brew cleanup
