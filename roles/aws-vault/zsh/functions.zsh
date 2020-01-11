#!/usr/local/bin/zsh

# avx -> aws-vault export
# Takes in a profile name and exports the generated keys
avx() {
    unset AWS_VAULT
    aws-vault exec --duration=1h "$1"
}
