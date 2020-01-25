#!/usr/local/bin/zsh

############################
### Custom Keybindings   ###
############################

# This make the up/down keys search through history and only
# match anything that's already been typed in the terminal
# https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Make cmd+right/left go to beginning and end of lines.
# You must also set your terminal emulator to send these
# escape code when cmd+right/left is pressed.
bindkey "\x1b[F" end-of-line       # cmd+right
bindkey "\x1b[H" beginning-of-line # cmd+left
