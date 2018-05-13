# git-all
# Commit all changes and push
ga() {
    git add -A
    git commit -m "'$*'"
    git push
}
