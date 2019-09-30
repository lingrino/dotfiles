#!/bin/sh

# Use fd instead of find
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# I run the below two commands instead of adding them
# manually using /usr/local/opt/fzf/install utility

# Add completions if in interactive mode
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2>/dev/null

# Add keybindings
source "/usr/local/opt/fzf/shell/key-bindings.zsh"
