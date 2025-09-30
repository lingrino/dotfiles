#!/usr/bin/env fish

function +x --description 'make file executable'
    chmod +x $argv
end
