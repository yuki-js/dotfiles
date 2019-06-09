#!/bin/sh

if ! [ -x "$(command -v brew)" ]; then
  echo 'Error: brew is not installed.' >&2
  exit 1
fi

brew cask install basictex
brew install pandoc # install if you want to convert md to tex
sudo tlmgr update --self --all
sudo tlmgr paper a4
sudo tlmgr install collection-langjapanese

echo "Installed!"

