#!/usr/bin/env fish

function e --description 'open editor at path. defaults to current directory.'
    if test (count $argv) -eq 0
        $EDITOR .
    else
        $EDITOR $argv[1]
    end
end
