#!/usr/bin/env fish

function o --description 'open file or directory at path. defaults to current directory.'
    if test (count $argv) -eq 0
        open .
    else
        open $argv
    end
end
