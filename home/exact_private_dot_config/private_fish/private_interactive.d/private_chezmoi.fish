#!/usr/bin/env fish

function dot --wraps='chezmoi update' --description 'alias dot=chezmoi update'
    chezmoi update $argv
end

abbr -a cm chezmoi
abbr -a cma 'chezmoi apply'
abbr -a cmd 'chezmoi diff'
abbr -a cmi 'chezmoi init'
abbr -a cms 'chezmoi status'
abbr -a cmu 'chezmoi unmanaged'
