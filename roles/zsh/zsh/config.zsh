#!/usr/local/bin/zsh

# Config Reference
# http://zsh.sourceforge.net/Doc/Release/Options.html
# Can also type `setopt ` and then tab for completion

# Some ideas from
# https://github.com/holman/dotfiles/blob/HEAD/zsh/config.zsh
# https://www.viget.com/articles/zsh-config-productivity-plugins-for-mac-oss-default-shell/

################################
### Terminal                 ###
################################
# Set terminfo to xterm-256color. Alacritty has its own terminfo that I WANT to use.
# Unfortunately is causes all kinds of problems with keybindings, SSH, dircolors, and
# likely many other things. The issue with keybindings should be solved in keybindings.zsh
# but I don't want to hunt around for other fixes when there's no obvious reason to
# user the Alacritty terminfo anyway
export TERM="xterm-256color"

################################
### History                  ###
################################
# HISTSIZE should always be a bit bigger than SAVEHIST
HISTFILE=~/.zsh_history
HISTSIZE=80000
SAVEHIST=50000

setopt SHARE_HISTORY                     # Share across sessions
setopt INC_APPEND_HISTORY                # Add to history as soon as they are run
setopt EXTENDED_HISTORY                  # Include timestamps and durations
setopt HIST_EXPIRE_DUPS_FIRST            # Remove duplicates before unique commands
setopt HIST_IGNORE_DUPS hist_ignore_dups # Don't add duplicates to history
setopt HIST_IGNORE_SPACE                 # Don't add commands that start with a space

################################
### Changing Directories     ###
################################
setopt AUTO_CD    # So that `~/Downloads` means `cd ~/Downloads`
setopt AUTO_PUSHD # Keep a stack of directories you cd into
setopt PUSHDMINUS # Use `-` instead of `+` to go back directories

################################
### Dircolors                ###
################################
# https://www.nordtheme.com/docs/ports/dircolors/installation
test -r ~/.dir_colors && eval $(gdircolors ~/.dir_colors)

################################
### Colored Man Pages        ###
################################
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
