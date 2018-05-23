# git-all
# Commit all changes and push
ga() {
    git add -A
    git commit -m "$*"
    git push
}

# Exports admin github personal access token
# egt -> export github token
egt () {
    TOKEN=$(lpass show -p 5317731538991673017)
    export GITHUB_PAT="$TOKEN"
    export GITHUB_TOKEN="$TOKEN"
    export GITHUB_ORGANIZATION="lingrino"
}
