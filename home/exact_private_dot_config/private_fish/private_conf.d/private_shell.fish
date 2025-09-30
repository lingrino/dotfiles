#!/usr/bin/env fish

# terminal
set -gx TERM xterm-256color

# grep
set -gx GREP_OPTIONS --color=auto

# man pages colors
set -gx LESS_TERMCAP_mb \e'[1;35m'
set -gx LESS_TERMCAP_md \e'[1;36m'
set -gx LESS_TERMCAP_me \e'[0m'
set -gx LESS_TERMCAP_se \e'[0m'
set -gx LESS_TERMCAP_so \e'[1;44;33m'
set -gx LESS_TERMCAP_ue \e'[0m'
set -gx LESS_TERMCAP_us \e'[1;32m'
