# Dotfiles

**NOTE:** This is is an example, not a drop in replacement, for your own dotfiles

## Bootstrap a new mac
```
curl -sSL https://raw.githubusercontent.com/Lingrino/dotfiles/master/bootstrap.sh | sh
```

## How this works
- Define new macs in `inventory` where the host is equal to `whoami` and the IP is 127.0.0.1
- Run the ansible like `ansible-playbook -i inventory -l $(whoami) main.yml`
- Once it's run the first time, you can rerun from anywhere by simply running `dot`
- The ansible will install all of your packages for you and place
- `zshrc` will look in `**/zsh/*.zsh` and source any files that it finds
- Defaults for all systems should go in `group_vars/all`

**TODO:**
- [ ] get public and privkey from 1password and write to .ssh
- [ ] vscode settings/extensions sync automated on new machines
- [ ] add github token to ~/.config/goreleaser
- [ ] add htop/hub (in ~/.config)
- [ ] template/write .localrc
- [ ] handle aws mfa
- [ ] handle .op folder
- [ ] function that logs into onepassword if not logged in
- [ ] call onepassword update command
- [ ] add bootstrap command
- [ ] add host specific config for on x mac and not y mac
