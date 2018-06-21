#!/bin/sh

# Check if dot is a command
if test $(which dot)
then
    echo "'dot' exists, you are already bootstrapped"
    exit 0
fi

# Check if xcode command line tools are installed
xcode-select -p &> /dev/null
if [ $? -ne 0 ]
then
    echo "xcode command line tools not installed, installing"
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
    TOOLS=$(softwareupdate -l |
        grep "\*.*Command Line" |
        head -n 1 | awk -F"*" '{print $2}' |
        sed -e 's/^ *//' |
        tr -d '\n')
    softwareupdate -i "$TOOLS" -v;
fi

# Check if dotfiles repo exists where it should
if test ! -d ~/projects/dotfiles
then
    echo "dotfiles are not at ~/projects/dotfiles, cloning to there"
    git clone git@github.com:Lingrino/dotfiles.git
fi
cd ~/projects/dotfiles

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
