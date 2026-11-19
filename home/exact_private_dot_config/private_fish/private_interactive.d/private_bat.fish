#!/usr/bin/env fish

function cat --wraps=bat --description 'alias cat=bat'
    bat $argv
end
