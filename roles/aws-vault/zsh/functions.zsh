# avx -> aws-vault export
# Takes in a profile name and exports the generated keys
avx () {
    unset AWS_VAULT
    aws-vault exec $1
}
