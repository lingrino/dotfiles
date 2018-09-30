# Use `hub` as our git wrapper:
#   https://hub.github.com/
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias g=$hub_path
  alias git=$hub_path
fi

alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gs='git status -sb'
alias gac='git add -A && git commit -m'
