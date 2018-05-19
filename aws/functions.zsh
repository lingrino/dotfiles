# Reads my AWS creds from lastpass and exports them
epc () {
    export AWS_ACCESS_KEY_ID=$(lpass show -u 2273816752644614863)
    export AWS_SECRET_ACCESS_KEY=$(lpass show -p 2273816752644614863)
}
