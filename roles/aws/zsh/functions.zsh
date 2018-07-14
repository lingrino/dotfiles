# Reads my AWS creds from lastpass and exports them
# epc -> export personal creds
epc () {
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN
    export AWS_ACCESS_KEY_ID=$(op get item llwcsrn5mzdm3nwyobkm7injaa | jq -r '.details.sections[] | select(.fields) | select(.fields[].t == "AWS_ACCESS_KEY_ID") | .fields[] | select(.t == "AWS_ACCESS_KEY_ID") | .v')
    export AWS_SECRET_ACCESS_KEY=$(op get item llwcsrn5mzdm3nwyobkm7injaa | jq -r '.details.sections[] | select(.fields) | select(.fields[].t == "AWS_SECRET_ACCESS_KEY") | .fields[] | select(.t == "AWS_SECRET_ACCESS_KEY") | .v')
    CREDS=$(aws sts get-session-token --serial-number arn:aws:iam::281050604782:mfa/sean --token-code $1)
    export AWS_ACCESS_KEY_ID=$(echo "$CREDS" | jq -r .Credentials.AccessKeyId)
    export AWS_SECRET_ACCESS_KEY=$(echo "$CREDS" | jq -r .Credentials.SecretAccessKey)
    export AWS_SESSION_TOKEN=$(echo "$CREDS" | jq -r .Credentials.SessionToken)
}

epcs () {
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN
    export AWS_ACCESS_KEY_ID=$(op get item 57bsrrdkcrgwjo2mlaqcqlrhce | jq -r '.details.sections[] | select(.fields) | select(.fields[].t == "AWS_ACCESS_KEY_ID") | .fields[] | select(.t == "AWS_ACCESS_KEY_ID") | .v')
    export AWS_SECRET_ACCESS_KEY=$(op get item 57bsrrdkcrgwjo2mlaqcqlrhce | jq -r '.details.sections[] | select(.fields) | select(.fields[].t == "AWS_SECRET_ACCESS_KEY") | .fields[] | select(.t == "AWS_SECRET_ACCESS_KEY") | .v')
    CREDS=$(aws sts get-session-token --serial-number arn:aws:iam::766970670128:mfa/sean --token-code $1)
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

aras () {
    CREDS=$(aws sts assume-role \
        --role-arn arn:aws:iam::766970670128:role/admin \
        --role-session-name AdminSean \
        --duration-seconds 3600 \
        --serial-number arn:aws:iam::766970670128:mfa/sean \
        --token-code "$1")
    export AWS_ACCESS_KEY_ID=$(echo "$CREDS" | jq -r .Credentials.AccessKeyId)
    export AWS_SECRET_ACCESS_KEY=$(echo "$CREDS" | jq -r .Credentials.SecretAccessKey)
    export AWS_SESSION_TOKEN=$(echo "$CREDS" | jq -r .Credentials.SessionToken)
}
