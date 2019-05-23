#!/bin/bash

# ask

read -p "Continue (y/n)?" CONT
if [ "$CONT" != "y" ]; then
    exit
fi

echo "Installing..."


# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install emacs
brew install zsh

# symlink dotfiles
DOT_FILES=(.emacs.d .zshrc .zprofile)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

chsh -s /usr/local/bin/zsh

# show hidden files

defaults write com.apple.Finder AppleShowAllFiles true
killall Finder

echo "Finished!"
