# This file is _path.zsh because it needs to be loaded after all other path files
# So the zshrc will load all path.zsh, then all *.zsh (incluing this file), making it last
export PATH="./bin:/usr/local/bin:/usr/local/sbin:$ZSH/roles/bin/bin:$PATH"
export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"
