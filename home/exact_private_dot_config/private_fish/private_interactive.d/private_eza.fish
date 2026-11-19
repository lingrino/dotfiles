#!/usr/bin/env fish

function l --wraps='eza -abghl' --description 'alias l=eza -abghl'
    eza -abghl $argv
end

function la --wraps='eza -abghl' --description 'alias la=eza -abghl'
    eza -abghl $argv
end

function ll --wraps='eza -bghl' --description 'alias ll=eza -bghl'
    eza -bghl $argv
end

function ls --wraps=eza --description 'alias ls=eza'
    eza $argv
end

function tree --wraps='eza --tree' --description 'alias tree=eza --tree'
    eza --tree $argv
end
