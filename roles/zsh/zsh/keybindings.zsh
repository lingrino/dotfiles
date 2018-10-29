#!/bin/sh

# Better history from https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Make cmd+left/right go to beginning and end of lines
bindkey "^[OH" beginning-of-line # cmd+left
bindkey "^[OF" end-of-line # cmd+left
