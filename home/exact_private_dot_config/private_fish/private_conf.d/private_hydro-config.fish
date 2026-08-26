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

# kube-ps1 configuration
set -g KUBE_PS1_SYMBOL_ENABLE false
set -g KUBE_PS1_NS_ENABLE true
set -g KUBE_PS1_PREFIX ''
set -g KUBE_PS1_SUFFIX ''
set -g KUBE_PS1_CTX_COLOR 60A5FA
set -g KUBE_PS1_NS_COLOR 60A5FA
set -g KUBE_PS1_HIDE_IF_NOCONTEXT true
set -g KUBE_PS1_CLUSTER_FUNCTION _hydro_kube_context

# print newline before prompt
function _hydro_newline --on-event fish_postexec
    echo
end

function _hydro_kube_context --description 'shorten the kubernetes context'
    string replace -r \
        '^arn:aws:eks:[^:]+:[^:]+:cluster/' '' -- $argv[1]
end

function _hydro_cloud_prompt --description 'show the active aws profile and kubernetes context'
    set -l segments

    set -l aws_profile $AWS_PROFILE
    test -z "$aws_profile"; and set aws_profile $AWS_DEFAULT_PROFILE

    if test -n "$aws_profile"
        set -a segments (set_color FF9900)$aws_profile
    end

    if functions -q kube_ps1
        set -l kube_prompt (kube_ps1)
        test -n "$kube_prompt"; and set -a segments $kube_prompt
    end

    if test (count $segments) -gt 0
        printf '%s' (string join (set_color brblack)' │ ' $segments)
        set_color normal
    end
end

# Keep cloud context on Hydro's first row instead of Fish's input-row right prompt.
function fish_prompt --description 'hydro with cloud context'
    set -l status_lines (string split '\\n' -- "$_hydro_status")

    if test (count $status_lines) -lt 2
        echo -e -n "$_hydro_color_start$hydro_symbol_start$hydro_color_normal$_hydro_color_pwd$_hydro_pwd$hydro_color_normal $_hydro_color_git$$_hydro_git$hydro_color_normal$_hydro_color_duration$_hydro_cmd_duration$hydro_color_normal$_hydro_status$hydro_color_normal "
        return
    end

    set -l left "$_hydro_color_start$hydro_symbol_start$hydro_color_normal$_hydro_color_pwd$_hydro_pwd$hydro_color_normal $_hydro_color_git$$_hydro_git$hydro_color_normal$_hydro_color_duration$_hydro_cmd_duration$hydro_color_normal$status_lines[1]$hydro_color_normal"
    set -l right (_hydro_cloud_prompt)

    if test -n "$right"
        set -l padding (math $COLUMNS - (string length --visible "$left") - (string length --visible "$right"))

        if test $padding -gt 0
            printf '%s%*s%s\n' "$left" $padding '' "$right"
        else
            printf '%s\n' "$left"
        end
    else
        printf '%s\n' "$left"
    end

    echo -e -n "$status_lines[2]$hydro_color_normal "
end
