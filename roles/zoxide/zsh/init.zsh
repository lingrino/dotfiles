#!/usr/local/bin/zsh

# This could be "cached" by running it during 'dot' and writing the result here instead.
eval "$(zoxide init zsh --no-define-aliases)"

# I prefer j over z
alias j='z'
alias ji='z -i'
alias ja='zoxide add'
alias jq='zoxide query'
alias jr='zoxide remove'
