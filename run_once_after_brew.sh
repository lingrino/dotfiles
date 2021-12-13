#!/usr/bin/env sh

# TODO change to run instead of run_once
exit 0

brew update
brew bundle --global
brew bundle cleanup --global --force
brew upgrade
brew cleanup
