#!/usr/local/bin/zsh

############################
### Setup Terminfo       ###
############################

# Read escape sequences from terminfo
# https://web.archive.org/web/20180603145728/http://zshwiki.org/home/zle/bindkeys
# https://github.com/jwilm/dotfiles/blob/51f4292046a77de60ee23bcf24198e9fd875fb35/zshrc#L119-L162

# This is weird but here's my understanding. Alacritty has its own terminfo database
# that sends difference escape sequences than zsh expects. This config is a way of
# reading the terminfo database so that we can expect the proper escape sequences
# in different terminal emulators (iTerm2 uses a different terminfo database).
# Note that Alacritty WORKS if you just never install the custom terminfo database
# and instead use `export TERM=xterm-256color` however there are claims that the
# custom database is better, although I'm not sure of the specifics. See the bottom
# section on this page - https://github.com/jwilm/alacritty/blob/master/INSTALL.md#terminfo

# NOTE: The above comment is still true, but I now `export TERM=xterm-256color`
#       and so some of these changes are not currently relevant. Maybe in the
#       future alacritty terminfo will be better supported.

# create a zkbd (zsh keybaord bindings) compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

# setup key accordingly
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-beginning-search
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-beginning-search
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

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

