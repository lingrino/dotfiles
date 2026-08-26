#!/usr/bin/env sh
set -euo pipefail

brew update 2>&1 | sed -e '/^==> Updating Homebrew\.\.\.$/d' -e '/^Already up-to-date\.$/d'
brew bundle --global | sed -e '/^Using /d' -e '/^`brew bundle` complete!/d'
brew bundle cleanup --global --force --zap
brew upgrade --yes
brew cleanup
