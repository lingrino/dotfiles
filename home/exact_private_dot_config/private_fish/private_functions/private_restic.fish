#!/usr/bin/env fish

function restic --description 'run restic with backup credentials' --wraps restic
    set -l env_file $HOME/.config/restic/env
    if not test -f "$env_file"
        echo "restic: $env_file not found" >&2
        return 1
    end

    bash -c "set -a; source '$env_file'; exec restic \"\$@\"" -- $argv
end
