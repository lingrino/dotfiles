#!/usr/bin/env fish

function top --wraps=btm --description 'alias top=btm'
    btm $argv
end
