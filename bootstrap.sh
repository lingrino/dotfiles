#!/bin/sh

# Fail on any errors
set -e

# Check if dot is a command
if test "$(command -v dot)"
then
    echo "'dot' exists, you are already bootstrapped"
    exit 0
fi

# Check if homebrew is already installed
# This also install xcode command line tools
if test ! "$(command -v brew)"
then
    echo "Homebrew not found, installing"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Create the projects folder if it does not exist
if test ! -d ~/projects
then
    echo "$HOME/projects does not exist, creating"
    mkdir ~/projects
fi

# Check if dotfiles repo exists where it should
if test ! -d ~/projects/dotfiles
then
    echo "dotfiles are not at ~/projects/dotfiles, cloning to there"
    git clone https://github.com/lingrino/dotfiles.git ~/projects/dotfiles
fi
cd ~/projects/dotfiles

# Check if pip3 is installed
if test ! "$(command -v pip3)"
then
    echo "pip3 not found, installing with homebrew"
    brew install python
fi

# Check if ansible is installed
if test ! "$(command -v ansible-playbook)"
then
    echo "ansible-playbook not found, installing with pip"
    pip3 install ansible
fi

# Ask the user what to name the host
echo "What do you want to name this host?"
read -r INVENTORY_NAME
if ! grep -q "$INVENTORY_NAME" inventory
then
    echo "$INVENTORY_NAME not found in inventory, adding"
    echo "you should push the new inventory back to git"
    echo "\n$INVENTORY_NAME" >> inventory
fi

echo "Successfully bootstrapped. You must now run the following command to install your dotfiles:"
echo "ansible-playbook -i ~/projects/dotfiles/inventory -l $INVENTORY_NAME ~/projects/dotfiles/main.yml -K --skip-tags \"post\""
echo "afterward you can enforce dotfile configuration at any time just by running 'dot'"

exit 0
