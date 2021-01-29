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

1. Create a file at `group_vars/all/secret.yml` based on `secret.yml.example` with your
   1Password details

1. Run the command that bootstrap returns, something like this

   ```bash
   ansible-playbook -i ~/projects/dotfiles/inventory -l $(cat ~/projects/dotfiles/me.txt) ~/projects/dotfiles main.yml -K --skip-tags "post"
   ```

1. Restart your mac

### Post Boostrap Manual Commands

1. Setup Touch ID for all things

1. 1Password

- Uncheck "show 1password in the menu bar"
- Uncheck "open 1password in the background"
- Mini -> Tags/Categories -> Hide
- Security -> Allow touchID to unlock 1password
- Watchtower -> Check for vulnerable passwords
- Browsers -> Check "Always keep extension helper running"
- Browsers -> Uncheck "detect and offer to save new usernames/passwords"
- Notifications -> Uncheck "one-time passwords"
- Advanced -> Check "Copy UUID" and "Copy JSON"
- Advanced -> Check "Enable third party integrations"

1. Finder

   Sidebar:
   - Airdrop
   - Applications
   - Documents
   - projects
   - Downloads

- Delete all tags
- Uncheck all locations and tags in sidebar except iCloud Drive
- Uncheck "show warning before removing from iCloud drive"

1. System Preferences

- General -> Change to dark
- Displays -> Turn off "automatically adjust brightness"
- Security -> General -> Require password immeditately
- Security -> General -> Allow Apple Watch to Unlock Mac
- Security -> FileVault -> Make sure FileVault is turned on, write down recovery key
- Spotlight -> Uncheck all except Applications, Contacts, Documents, System Preferences
- Spotlight -> Uncheck "allow spotlight suggestions in lookup"
- Notifications -> Do Not Disturb -> Turn on DND from 19:00 to 09:00
- Notifications -> Do Not Disturb -> Check "allow repeated calls"
- Notifications -> Disable all except those needed
- Notifications -> Don't allow any on lockscreen
- Notifications -> Always show notification preview
- Notifications -> Never show in notification center
- Keyboard -> Modifier Keys -> Change 'Caps Lock' to 'Escape'
- Keyboard -> Uncheck "adjust keyboard brightness"
- Keyboard -> Disable all text substitutes
- Keyboard -> Uncheck capitalize automatically
- Keyboard -> Uncheck touch bar typing suggestions
- Keyboard -> Shortcuts -> Uncheck every shortcut
- Keyboard -> Input Sources -> Uncheck "show input in menu bar"
- Keyboard -> Dictation -> Change the shortcut to "off"
- Trackapd -> More Gestures -> Disable notification center, mission control, show desktop
- Sound -> Disable user interface sound effects
- iCloud -> Photos -> Enable All
- iCloud -> Turn on all except Mail, Calendars, Contacts
- Internet Accounts -> Remove game center
- Internet Accounts -> Sign in to google for contacts only
- Software Update -> Automatically install everything
- Extensions -> Share Menu -> Uncheck all possible
- Extensions -> Today -> Uncheck all
- Users and Groups -> Change profile picture to vinyl record
- Users and Groups -> Disable guest
- Accessibility -> General -> Turn off shortcuts

1. Alfred

- Enter your license key from 1password
- Change the hotkey to cmd+space
- Change the theme to "Alfred macOS Dark"
- Enable settings sync from cloud drive

1. iTerm

- set to load preferences from cloud drive
- Do not save current settings
- Restart iterm and then check "save changes to foler when iterm quits"

### Final Commands

1. Change the dotfiles git origin to use ssh

   ```shell
   cd ~/projects/dotfiles
   git remote rename origin originold
   git remote add origin git@github.com:lingrino/dotfiles.git
   git remote remove originold
   ```

1. Open the dotfiles with `e ~/projects/dotfiles`

- Add any custom changes to `host_vars/inventory_name/me.txt)/*.yml`. Use other
  `host_vars` as a template
- Copy `group_vars/all/op_secret.yml.example` to `group_vars/all/op_secret.yml`
- Fill out `secret.yml` with your details

1. Commit your changes
1. Run `dot all`
1. Restart your mac one final time

## Inspiration

- [holman/dotfiles](https://github.com/holman/dotfiles)
- [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook).
