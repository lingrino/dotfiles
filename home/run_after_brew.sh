#!/usr/bin/env sh
set -euo pipefail

brew update
brew bundle --global
brew bundle cleanup --global --force
brew upgrade
brew cleanup
