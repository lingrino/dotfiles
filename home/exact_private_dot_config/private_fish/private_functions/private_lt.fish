#!/usr/bin/env fish

function lt --description 'list tree with optional depth'
    if test (count $argv) -eq 0
        eza -bghlT
    else
        eza -bghlT -L $argv[1]
    end
end
