# Dotfiles

**NOTE:** This is is an example, not a drop in replacement, for your own dotfiles

## How this works
- Define new macs in `inventory` where the host is equal to `$(whoami)` and the IP is 127.1.1.1
- `zshrc` will look in `**/zsh/*.zsh` and source any files that it finds

## Setup
Once the initial setup is complete all that is needed to make changes and keep the mac
enforced is a semi-regular run of `dot`. To setup a mac for the first time follow the below
instructions. Unfortunately not everything can be done automatically (or I haven't gotten to it),
so there's some manual steps.

### Initial Bootstrap
1. Follow the on-screen mac instructions for first-time setup
    - Disable Siri
    - Disable analytics reporting
1. Open terminal, and run the following command
    ```
    curl -sSL https://raw.githubusercontent.com/Lingrino/dotfiles/master/bootstrap.sh | sh
    ```
1. Run the command that bootstrap returns, something like this
    ```
    ansible-playbook -i ~/projects/dotfiles/inventory -l $(whoami) ~/projects/dotfiles/main.yml -K --skip-tags "post"
    ```
1. Restart your mac

### Post Boostrap Manual Commands
1. Open and login to 1password
1. Login to the dropbox app
    - Disable finder integration
    - Disable camera uploads
    - Disable screenshot sharing
    - Disable notifications
    - Enable selective sync on only desired folders
1. Open finder and remove all items from the sidebar except (in order)
    - Airdrop
    - Applications
    - projects
    - Downloads
1. Open finder settings
    - Delete all tags
    - Uncheck "show warning before removing from iCloud drive"
1. Open system preferences
    - General -> firefox to default web browser
    - Security -> General -> Require password immeditately
    - Spotlight -> disable spotlight suggestions in lookup
    - Spotlight -> privacy -> prevent spotlight from accessing macintosh HD
    - Displays -> turn off "automatically adjust brightness"
    - Displays -> change the resolution to "more space"
    - Keyboard -> Uncheck "adjust keyboard brightness"
    - Keyboard -> disable all text substitutes
    - Keyboard -> Uncheck capitalize automatically
    - Keyboard -> Disable the spotlight cmd+space hotkey
    - Trackpad -> Scroll and Zoom -> disable pinch, zoom, and rotate
    - Trackapd -> More Gestures -> Disable notification center, mission control, show desktop
    - Sound -> Disable user interface sound effects
    - iCloud -> iCloud Drive -> Turn off "Desktop and Documents Folders"
    - iCloud -> Turn off mail, calendar, safari
    - Internet Accounts -> remove game center
    - Internet Accounts -> sign in to google, only sync contacts
    - App Store -> install app updates/mac updates/
    - Extensions -> Share Menu -> Uncheck all possible
    - Extensions -> Today -> Uncheck all
    - Users and Groups -> Disable guest
    - Users and Groups -> self -> login items -> disable iTunes
    - Accessibility -> General -> Turn off shortcuts
1. Open Alfred settings
    - Change the hotkey to cmd+space
    - Change the theme to "Alfred macOS"
    - Enter your license key from 1password
    - Enable settings sync at `~/Dropbox/settings/alfred`
1. Open iterm settings set to load preferences from ~/Dropbox/settings/iterm
1. Open vscode to sync settings
    - Install the [settings sync extension](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync)
    - Press cmd+shift+p and type sync, hit enter
    - For personal access token enter the one found in 1password 'Github' login notes
    - For gist ID enter `6ff61f3d01c5772138f5d928471c40c4`

### Final Commands
1. Open the dotfiles with `e ~/projects/dotfiles`
    - Add any custom changes to `host_vars/$(whoami)/*.yml`. Use other `host_vars` as a template
    - Copy `group_vars/all/secret.yml.example` to `group_vars/all/secret.yml`
    - Fill out `secret.yml` with your details
1. Commit your changes
1. Run `dot all`
1. Restart your mac one final time

## Tags
TODO - Add explanantion of different task tags here

## Dot
TODO - Add explanation of dot command here

**TODO:**
- [ ] add github token to ~/.config/goreleaser
- [ ] add htop/hub (in ~/.config)
- [ ] template/write .localrc
- [ ] handle aws mfa
- [ ] handle .op folder
- [ ] function that logs into onepassword if not logged in
- [ ] call onepassword cli update command on dot
- [ ] switch to hyper
- [ ] Keyboard shortcuts with karabiner
- [ ] disable itunes completely
- [ ] "Show the users library folder" doesn't actually work
- [ ] Spotlight mac changes don't work/persist
- [ ] Remove spotlight icon from menu bar (can with cmd+drag)
- [ ] Copy over settings for ctrl+R
- [ ] Disable notification center completely
- [ ] Map capslock to esc
- [ ] Brew task should call `brew update`
