#!/bin/sh

# avx -> aws-vault export
# Takes in a profile name and exports the generated keys
avx () {
    unset AWS_VAULT
    aws-vault exec --session-ttl=4h --assume-role-ttl=1h "$1"
}
