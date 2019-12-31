# Setting Up A New Mac

## Initial Bootstrap

1. Follow the on-screen mac instructions for first-time setup

1. Run all mac software updates

1. Open terminal and run the following command

   ```bash
   sh -c "$(curl -sSL https://raw.githubusercontent.com/lingrino/dotfiles/master/bootstrap.sh)"
   ```

1. Create a file at `group_vars/all/secret.yml` based on `secret.yml.example` with your
   1Password details

1. Run the command that bootstrap returns, something like this

   ```bash
   ansible-playbook -i ~/projects/dotfiles/inventory -l $(cat dotfiles_dir/me.txt) ~/projects/dotfiles/main.yml -K --skip-tags "post"
   ```

1. Restart your mac

## Post Boostrap Manual Commands

1. Open system preferences and set up Touch ID

- Use Touch ID for all the things

1. Open and login to 1password

- Uncheck "show 1password in the menu bar"
- Uncheck "open 1password in the background"

1. Open 1password settings

- Mini -> Tags -> Hide
- Security -> Allow touchID to unlock 1password
- Watchtower -> Check for vulnerable passwords
- Browsers -> Check "Always keep extension helper running"
- Browsers -> Uncheck "detect and offer to save new usernames/passwords"
- Advanced -> Check "Copy UUID" and "Copy JSON"
- Advanced -> Check "Enable third party integrations"

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
- Uncheck all locations and tags in sidebar
- Uncheck "show warning before removing from iCloud drive"

1. Open Notification Center and remove all widgets

1. Open system preferences

- General -> Change to dark
- General -> Chrome to default web browser
- Displays -> Turn off "automatically adjust brightness"
- Displays -> Change the resolution to "more space"
- Security -> General -> Require password immeditately
- Security -> General -> Allow Apple Watch to Unlock Mac
- Security -> FileVault -> Make sure FileVault is turned on, write down recovery key
- Spotlight -> Uncheck all except Applications, Contacts, Documents, System Preferences
- Spotlight -> Uncheck "allow spotlight suggestions in lookup"
- Notifications -> Do Not Disturb -> Turn on DND from 19:00 to 09:00
- Notifications -> Do Not Disturb -> Check "allow repeated calls"
- Notifications -> Disable all except
  - 1password: Banners
  - FaceTime: Sounds, Alerts
  - Messages: Badges, Banners
  - Things: Badges, Banners
- Notifications -> Don't allow any on lockscreen
- Notifications -> Always show notification preview
- Notifications -> Never show in notification center
- Keyboard -> Modifier Keys -> Change 'Caps Lock' to 'Escape'
- Keyboard -> Uncheck "adjust keyboard brightness"
- Keyboard -> Disable all text substitutes
- Keyboard -> Uncheck capitalize automatically
- Keyboard -> Uncheck touch bar typing suggestions
- Keyboard -> Shortcuts -> Uncheck every shortcut except screenshots
- Keyboard -> Input Sources -> Uncheck "show input in menu bar"
- Keyboard -> Dictation -> Change the shortcut to "off"
- Trackapd -> More Gestures -> Disable notification center, mission control, show desktop
- Sound -> Disable user interface sound effects
- iCloud -> iCloud Drive -> Turn off "Desktop and Documents Folders"
- iCloud -> Photos -> Enable All
- iCloud -> Turn on all except Mail, Calendars
- Internet Accounts -> Remove game center
- Internet Accounts -> Sign in to fastmail with calendar sync
- Internet Accounts -> Sign in to google for work if applicable and sync calendar
- Software Update -> Automatically install everything
- Extensions -> Share Menu -> Uncheck all possible
- Extensions -> Today -> Uncheck all
- Users and Groups -> Change profile picture to vinyl record
- Users and Groups -> Disable guest
- Users and Groups -> self -> login items -> hide Dropbox
- Accessibility -> General -> Turn off shortcuts

1. Open Alfred settings

- Enter your license key from 1password
- Change the hotkey to cmd+space
- Change the theme to "Alfred macOS Dark"
- Enable settings sync at `~/Dropbox/settings/alfred`

1. Open iterm settings and set to load preferences from ~/Dropbox/settings/iterm

- Do not save current settings
- Restart iterm and then check "save changes to foler when iterm quits"

1. Open vscode to sync settings

- Install the [settings sync
  extension](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync)
- Login with github account
- Select gist ID `6ff61f3d01c5772138f5d928471c40c4`
- Press cmd+shift+p and type `Sync: Download Settings`

1. Open Messages settings

- Sync with iCloud
- Enable read receipts
- Disable sound effects

1. Open FaceTime settings

- Turn on wifi calling

1. Open Chrome and sign in with Google

- Hide all extensions in the top bar except pocket

1. Open slack and sign in to all workspaces
1. Open Things, sign in, and enable Things Cloud

- Enable calendar events sync

1. Open Bear and make sure it Syncs
1. Open Docker and grant it permissions
1. Open Keybase and sign in

- Make sure to revoke any old devices

1. Open Zoom and sign in to account
1. Open iTunes and agree, then open settings

- Enable iCloud music library
- Crossfade songs for 1 second
- Enable sound check
- Sync podcast subscription and settings
- Automatically download album artwork

## Final Commands

1. Change the dotfiles git origin to use ssh

   ```shell
   cd ~/projects/dotfiles
   git remote rename origin originold
   git remote add origin git@github.com:lingrino/dotfiles.git
   git remote remove originold
   ```

1. Open the dotfiles with `e ~/projects/dotfiles`

- Add any custom changes to `host_vars/$(cat dotfiles_dir/me.txt)/*.yml`. Use other
  `host_vars` as a template
- Copy `group_vars/all/op_secret.yml.example` to `group_vars/all/op_secret.yml`
- Fill out `secret.yml` with your details

1. Commit your changes
1. Run `dot all`
1. Restart your mac one final time