#!/usr/bin/env fish

abbr -a p python

function python --wraps=python3 --description 'alias python=python3'
    python3 $argv
end

function pip --wraps=pip3 --description 'alias pip=pip3'
    pip3 $argv
end
