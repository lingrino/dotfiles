# Dotfiles

Welcome to my dotfiles!

## Setting Up A New Mac

### Initial Bootstrap

1. Follow the on-screen mac instructions for first-time setup

1. Run all mac software updates

1. Open terminal and run the following command

   ```bash
   sh -c "$(curl -sSL https://raw.githubusercontent.com/lingrino/dotfiles/HEAD/bootstrap.sh)"
   ```

1. Run the command that bootstrap returns, something like this

   ```bash
   ansible-playbook -i ~/projects/dotfiles/inventory -l $(cat ~/projects/dotfiles/me.txt) ~/projects/dotfiles main.yml -K --skip-tags "post"
   ```

1. Restart your mac

### Post Boostrap Manual Commands

1. Setup Touch ID for all things

1. Open all apps and set up preferences

1. Open all system preferences and configure

1. Alfred

- Enter your license key from 1password
- Change the hotkey to cmd+space
- Enable settings sync from cloud drive

1. iTerm

- Set to load preferences from cloud drive
- Do not save current settings
- Restart iterm and then check "save changes to foler when iterm quits"

### Final Commands

1. Change the dotfiles git origin to use ssh

   ```shell
   cd ~/projects/dotfiles
   git remote rename origin originold
   git remote add origin git@github.com:lingrino/dotfiles.git
   git remote remove originold
   git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main
   ```

1. Commit your changes
1. Run `dot all`
1. Restart your mac one final time

## Inspiration

- [holman/dotfiles](https://github.com/holman/dotfiles)
- [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook).
