#!/usr/bin/env fish

__cached_init zoxide init fish --cmd j

function __zoxide_hook --on-variable PWD
    test -n "$fish_private_mode"; and return
    command zoxide add -- (__zoxide_pwd) &
end
