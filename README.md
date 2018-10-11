# Dotfiles

**NOTE:** This is is an example, not a drop in replacement, for your own dotfiles

## How this works

- Define new macs in `inventory` where the host is equal to `$(cat dotfiles_dir/me.txt)` and
- `zshrc` will look in `**/zsh/*.zsh` and source any files that it finds

## Setup

Once the initial setup is complete all that is needed to make changes and keep the mac
enforced is a semi-regular run of `dot`. To setup a mac for the first time follow the below
instructions. Unfortunately not everything can be done automatically (or I haven't gotten to it),
so there's some manual steps.

## Dot

After bootstrap you can periodically run the `dot` command to keep your system in sync. By default `dot`
runs all ansible except mac settings configuration and anything that requires sudo or auth to 1Password. You
can run `dot most` to include the mac settings and `dot all` to include sudo and 1Password commands, which
require user input.

## Tags

Many of the ansible commands contain tags. Some of them are not used yet, but keeping things tags makes slicing
easier now and in the future. Here's a list of tags:

- **1password:** Tags all tasks that require auth to 1Password
- **internet:** Tags all tasks that can only be run with internet access
- **post:** Tags all tasks that must be run after bootstrap is run
- **sudo:** Tags all tasks that require sudo

### Initial Bootstrap

1. Follow the on-screen mac instructions for first-time setup
    - Disable Siri
    - Disable analytics reporting
1. Open terminal, and run the following command

    ```bash
    curl -sSL https://raw.githubusercontent.com/Lingrino/dotfiles/master/bootstrap.sh | sh
    ```

1. Create a file at `group_vars/all/secret.yml` based on `secret.yml.example` with your 1Password details

1. Run the command that bootstrap returns, something like this

    ```bash
    ansible-playbook -i ~/projects/dotfiles/inventory -l $(cat dotfiles_dir/me.txt) ~/projects/dotfiles/main.yml -K --skip-tags "post"
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
1. Remove the spotlight icon from the menu bar by holding CMD and dragging it off
1. Open Notification Center and remove all widgets
1. Open system preferences
    - Appearance -> Change to dark
    - General -> Firefox to default web browser
    - Security -> General -> Require password immeditately
    - Security -> General -> Allow Apple Watch to Unlock Mac
    - Spotlight -> Uncheck all except Applications, Documents, Contacts, System Preferences
    - Notifications -> Disable all except 1Password, Alfred, FaceTime, Firefox, Hyper, iTerm, Messages, Slack
    - Notifications -> Don't allow on lockscreen, don't allow sound except on FaceTime, Firefox
    - Displays -> Turn off "automatically adjust brightness"
    - Displays -> Change the resolution to "more space"
    - Keyboard -> Modifier Keys -> Change 'Caps Lock' to 'Escape'
    - Keyboard -> Uncheck "adjust keyboard brightness"
    - Keyboard -> Disable all text substitutes
    - Keyboard -> Uncheck capitalize automatically
    - Keyboard -> Disable the spotlight cmd+space hotkey
    - Keyboard -> Shortcuts -> Uncheck every shortcut except screenshots
    - Keyboard -> Dictation -> Change the shortcut to "off"
    - Trackpad -> Scroll and Zoom -> disable pinch, zoom, and rotate
    - Trackapd -> More Gestures -> Disable notification center, mission control, show desktop
    - Sound -> Disable user interface sound effects
    - iCloud -> iCloud Drive -> Turn off "Desktop and Documents Folders"
    - iCloud -> Photos -> Only enable shared albums
    - iCloud -> Turn off mail, calendar, safari, news, stocks, home, siri, reminders
    - Internet Accounts -> remove game center
    - Internet Accounts -> sign in to google, only sync contacts
    - Software Update -> Automatically install everything
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
1. Open iterm settings and set to load preferences from ~/Dropbox/settings/iterm
1. Open vscode to sync settings
    - Install the [settings sync extension](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync)
    - Press cmd+shift+p and type sync, hit enter
    - For personal access token enter the one found in 1password 'Github' login notes
    - For gist ID enter `6ff61f3d01c5772138f5d928471c40c4`

### Final Commands

1. Open the dotfiles with `e ~/projects/dotfiles`
    - Add any custom changes to `host_vars/$(cat dotfiles_dir/me.txt)/*.yml`. Use other `host_vars` as a template
    - Copy `group_vars/all/secret.yml.example` to `group_vars/all/secret.yml`
    - Fill out `secret.yml` with your details
1. Commit your changes
1. Run `dot all`
1. Restart your mac one final time
