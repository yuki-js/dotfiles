#!/bin/bash

# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install emacs
brew install zsh


DOT_FILES=(.emacs.d .zshrc .zprofile)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/codes/dotfiles/$file $HOME/$file
done

chsh -s /usr/local/bin/zsh
