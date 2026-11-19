#!/usr/bin/env fish

if not set -q ATUIN_SESSION; or test "$ATUIN_SHLVL" != "$SHLVL"
    set -gx ATUIN_SESSION (printf %08x%08x%08x%08x (random 0 4294967295) (random 0 4294967295) (random 0 4294967295) (random 0 4294967295))
    set -gx ATUIN_SHLVL $SHLVL
end

__cached_init atuin init fish

set -g __atuin_tmp (path filter -d -w -- $TMPDIR /tmp)[1]
set -g __atuin_seq 0

functions -c _atuin_preexec __atuin_sync_preexec

function _atuin_preexec --on-event fish_preexec
    test -n "$fish_private_mode"; and return
    if test "$__atuin_pty_proxy_owns_tty" = 1
        __atuin_sync_preexec $argv
        return
    end

    set __atuin_seq (math $__atuin_seq + 1)
    set -g __atuin_id_file $__atuin_tmp/atuin-fish.$fish_pid.$__atuin_seq
    command sh -c 'id=$(ATUIN_SHELL=fish atuin history start --hook -- "$1" 2>/dev/null); echo "$id" >"$2"' \
        sh $argv[1] $__atuin_id_file &>/dev/null &
    disown
end

function __atuin_end_async
    command sh -c 'n=0
        while [ ! -s "$1" ] && [ $n -lt 300 ]; do sleep 0.01; n=$((n + 1)); done
        read -r id <"$1"; rm -f "$1"
        [ -n "$id" ] && exec atuin history end --hook --exit "$2" --duration "$3" -- "$id"' \
        sh $__atuin_id_file $argv &>/dev/null &
    disown
    set -e __atuin_id_file
end

function _atuin_postexec --on-event fish_postexec
    set -l s $status

    if set -q __atuin_id_file
        __atuin_end_async $s (math --scale=0 $CMD_DURATION \* 1000000)
    else if test -n "$ATUIN_HISTORY_ID"
        _atuin_mark_output_end $s
        atuin history end --hook --exit $s -- $ATUIN_HISTORY_ID &>/dev/null &
        disown
    end

    set -e ATUIN_HISTORY_ID
end

function __atuin_exit --on-event fish_exit
    set -q __atuin_id_file; and __atuin_end_async $status 0
end
