#!/bin/sh

# Check if we're in the right directory
if test ! -f inventory || test ! -f main.yml
then
    echo "either 'inventory' or 'main.yml' file does not exist in this directory"
    echo "you must run ./bootstrap.sh from the root of the dotfile directory"
    exit 1
fi

# Check if homebrew is already installed
if test ! $(which brew)
then
    echo "Homebrew not found, installing"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Check if pip3 is installed
if test ! $(which pip3)
then
    echo "pip3 not found, installing with homebrew"
    brew install python
fi

# Check if ansible is installed
if test ! $(which ansible-playbook)
then
    echo "ansible-playbook not found, installing with pip"
    pip3 install ansible
fi

# Check if user exists in inventory
if ! grep -q "$(whoami)" inventory
then
    echo "$(whoami) not found in inventory, adding"
    echo "you should push the new inventory back to git"
    echo "\n[$(whoami)]\n127.0.0.1" >> inventory
fi

echo "Successfully bootstrapped. You must now run the following command to install your dotfiles:"
echo "ansible-playbook -i inventory -l $(whoami) main.yml -K"
echo "afterward you can enforce dotfile configuration at any time just by running 'dot'"

exit 0
