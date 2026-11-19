#!/usr/bin/env fish

function find --wraps=fd --description 'alias find=fd'
    fd $argv
end
