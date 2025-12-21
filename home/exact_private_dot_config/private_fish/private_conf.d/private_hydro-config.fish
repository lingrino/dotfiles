#!/usr/bin/env fish

# hydro prompt configuration
# https://github.com/jorgebucaran/hydro

set -g hydro_multiline true
set -g hydro_symbol_prompt ❯
set -g fish_prompt_pwd_dir_length 50
set -g hydro_cmd_duration_threshold 300

set -g hydro_color_pwd cyan
set -g hydro_color_git magenta
set -g hydro_color_prompt green
set -g hydro_color_duration yellow

# print newline before prompt
function _hydro_newline --on-event fish_postexec
    echo
end
