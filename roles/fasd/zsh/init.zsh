#!/usr/local/bin/zsh

# Caching code from https://github.com/clvv/fasd
fasd_cache="$HOME/.fasd-init-zsh"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init zsh-hook >|"$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache
