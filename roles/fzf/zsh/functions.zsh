#!/bin/bash

# If no args, call fasd_cd with fzf on input
# If args, just call fasd_cd
j() {
    [ $# -gt 0 ] && fasd_cd -d "$*" && return
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}
