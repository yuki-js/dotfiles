#!/bin/bash

# ask

echo "Check if this file is $HOME/codes/dotfiles/install.sh"

read -p "Continue (y/n)?" CONT
if [ "$CONT" != "y" ]; then
    exit
fi

echo "Installing..."


# install homebrew
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew cask install emacs
brew install zsh
brew install git

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

sudo bash -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
chsh -s /usr/local/bin/zsh

# show hidden files

defaults write com.apple.Finder AppleShowAllFiles true
killall Finder


echo "Finished! Opening Emacs... Press C-x C-c later."
sleep 3
emacs -nw
