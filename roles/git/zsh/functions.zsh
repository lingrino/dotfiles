# Exports admin github personal access token
# egt -> export github token
egt () {
    TOKEN=$(op get item od3m7tmx2jd43paxpoekqy6ihi | jq -r '.details.fields[] | select(.name == "password") | .value')
    export GITHUB_PAT="$TOKEN"
    export GITHUB_TOKEN="$TOKEN"
    export GITHUB_ORGANIZATION="lingrino"
}
