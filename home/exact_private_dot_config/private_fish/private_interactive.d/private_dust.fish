#!/usr/bin/env fish

function du --wraps=dust --description 'alias du=dust'
    dust $argv
end

function dust --description 'alias dust=dust -r'
    command dust -r $argv
end
