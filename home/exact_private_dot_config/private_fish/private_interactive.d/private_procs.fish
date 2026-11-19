#!/usr/bin/env fish

function ps --wraps=procs --description 'alias ps=procs'
    procs $argv
end
