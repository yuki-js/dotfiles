#!/bin/bash



# ask

# echo "Check if this file is $HOME/codes/dotfiles/install.sh"

if [ $(cd $(dirname $0); pwd) != "$HOME/codes/dotfiles" ]; then
    echo "Rerun this file at $HOME/codes/dotfiles/install.sh"
    exit
fi

read -p "Continue (y/n)?" CONT
if [ "$CONT" != "y" ]; then
    exit
fi

echo "Installing..."


# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew cask install emacs
brew cask install iterm2
brew install zsh
brew install git
brew cask install google-chrome

# symlink dotfiles
DOT_FILES=(.emacs.d .zshrc .zprofile)

for file in ${DOT_FILES[@]}
do
    if [ -e "$HOME/codes/dotfiles/$file" ] ; then

	      ln -s $HOME/codes/dotfiles/$file $HOME/$file
    else
	      echo "File $HOME/codes/dotfiles/$file not found"
    fi
done

# change login shell

sudo bash -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
chsh -s /usr/local/bin/zsh

# show hidden files & disable dashboard completely

defaults write com.apple.Finder AppleShowAllFiles true
defaults write com.apple.dashboard mcx-disabled -boolean YES
defaults write com.apple.screencapture location ~/Pictures/Screenshots
killall Finder
killall Dock


echo "Finished!"
