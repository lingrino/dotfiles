#!/bin/bash

# fzf is amazing and there's so many more things I could do
# with it than I currenttly do.
# Examples - https://github.com/junegunn/fzf/wiki/Examples

# j() uses fasd and fzf to do a fuzzy jump to a recent directory
# with no arguments we call interactive fzf on our directories
# with one argument with jump to the closest matched directory
j() {
    local dir
    if [ $# -gt 0 ]; then
        dir="$(fasd -dl1 "$@")"
        if [ -z "${dir}" ]; then
            echo "Nothing found"
        else
            cd "${dir}" || return 1
        fi
    else
        dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)"
        cd "${dir}" || return 1
    fi
}
