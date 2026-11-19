#!/usr/bin/env fish

status is-interactive; or return

function __cached_init --description 'source cached output of a tool init command'
    set -l bin (command -s $argv[1]); or return
    set bin (path resolve -- $bin)
    set -l key "# $bin "(path mtime -- $bin)
    set -l cache $__fish_cache_dir/init/(string join -- _ $argv).fish
    set -l line
    if not test -f $cache; or not read line <$cache; or test "$line" != "$key"
        set -l script (command $argv); or return
        set script (string replace --regex -- '^alias ([\w-]+)=(?!\1$)([\w-]+)$' \
            'function $1 --wraps=$2 --description \'alias $1=$2\'\n    $2 $$argv\nend' $script)
        command mkdir -p $__fish_cache_dir/init
        printf '%s\n' $key $script >$cache.$fish_pid
        and command mv -f $cache.$fish_pid $cache
        or return
    end
    source $cache
end

# source interactive configs
for file in $__fish_config_dir/interactive.d/*.fish
    source $file
end
