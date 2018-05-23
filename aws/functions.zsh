# Reads my AWS creds from lastpass and exports them
# epc -> export personal creds
epc () {
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN
    export AWS_ACCESS_KEY_ID=$(lpass show -u 2273816752644614863)
    export AWS_SECRET_ACCESS_KEY=$(lpass show -p 2273816752644614863)
    CREDS=$(aws sts get-session-token --serial-number arn:aws:iam::281050604782:mfa/sean --token-code $1)
    export AWS_ACCESS_KEY_ID=$(echo "$CREDS" | jq -r .Credentials.AccessKeyId)
    export AWS_SECRET_ACCESS_KEY=$(echo "$CREDS" | jq -r .Credentials.SecretAccessKey)
    export AWS_SESSION_TOKEN=$(echo "$CREDS" | jq -r .Credentials.SessionToken)
}

# Assumes the admin role using my creds
# ara -> assume role admin
ara () {
    CREDS=$(aws sts assume-role \
        --role-arn arn:aws:iam::281050604782:role/admin \
        --role-session-name AdminSean \
        --duration-seconds 3600 \
        --serial-number arn:aws:iam::281050604782:mfa/sean \
        --token-code "$1")
    export AWS_ACCESS_KEY_ID=$(echo "$CREDS" | jq -r .Credentials.AccessKeyId)
    export AWS_SECRET_ACCESS_KEY=$(echo "$CREDS" | jq -r .Credentials.SecretAccessKey)
    export AWS_SESSION_TOKEN=$(echo "$CREDS" | jq -r .Credentials.SessionToken)
}
