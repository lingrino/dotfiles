###############################################################################
# General UI/UX                                                               #
###############################################################################
# Set standby delay to 24 hours (default is 1 hour)
sudo pmset -a standbydelay 86400

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Disable hibernation (speeds up entering sleep mode)
sudo pmset -a hibernatemode 0

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Never go into computer sleep mode
sudo systemsetup -setcomputersleep Off > /dev/null

# Enable with sudo chmod +x /Applications/iTunes.app/Contents/MacOS/iTunes
sudo chmod -x /Applications/iTunes.app/Contents/MacOS/iTunes

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal
