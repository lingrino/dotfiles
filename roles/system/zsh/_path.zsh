#!/bin/sh

# This file is _path.zsh because it needs to be loaded after all other path files
# So the zshrc will load all path.zsh, then all *.zsh (incluing this file), making it last
# Load /usr/local/bin after roles/bin/bin so that the latter can take precedence
export PATH="./bin:$ZSH/roles/bin/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"
