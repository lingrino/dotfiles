#!/usr/bin/env fish

function e --description 'open zed at path. defaults to current directory.'
    if test (count $argv) -eq 0
        zed .
    else
        zed $argv[1]
    end
end
