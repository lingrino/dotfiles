#!/usr/bin/env fish

function chezmoi --description 'Run chezmoi with the dotfiles 1Password service account'
    set -l token_file "$HOME/.config/op/service-account-token"

    if not test -r "$token_file"
        printf 'chezmoi: service account token not found: %s\n' "$token_file" >&2
        return 1
    end

    # Limit the service account to chezmoi and the commands it starts.
    set -lx OP_SERVICE_ACCOUNT_TOKEN (string trim < "$token_file")
    command chezmoi $argv
end
