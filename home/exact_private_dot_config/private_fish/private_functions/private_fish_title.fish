#!/usr/bin/env fish

function fish_title
    set -l ssh
    set -q SSH_TTY
    and set ssh "["(prompt_hostname | string sub -l 10 | string collect)"]"

    if test "$__fish_title_pwd_dir" != "$PWD"
        set -g __fish_title_pwd (prompt_pwd -d 1 -D 1)
        set -g __fish_title_pwd_dir $PWD
    end

    if set -q argv[1]
        echo -- $ssh (string sub -l 20 -- $argv[1]) $__fish_title_pwd
    else
        set -l command (status current-command)
        if test "$command" = fish
            set command
        end
        echo -- $ssh (string sub -l 20 -- $command) $__fish_title_pwd
    end
end
