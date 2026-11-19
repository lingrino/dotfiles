#!/usr/bin/env fish

function sme --description 'export secret to env'
    # jq emits each key and value as its own NUL-terminated record, so values
    # are set verbatim (spaces, quotes, newlines) and never parsed as fish code.
    aws --profile prod secretsmanager get-secret-value --secret-id $argv[1] --query SecretString --output text |
        jq --join-output 'to_entries[] | "\(.key)\u0000\(.value)\u0000"' |
        while read --local --null key
            read --local --null value
            set -gx $key $value
        end
end
