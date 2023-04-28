#!/bin/bash
set -eu


# abort if superuser
if [ $(id -u) -eq 0 ]; then
  echo "Fatal error: This script must not be run as root"
  exit 1
fi
MAKE_ME_ROOT="sudo"
# assume debian like distro, no check

FILES_TO_BE_TRANSPLANTED_TO_HOME=(
  $HOME/codes/dotfiles/cfgs/.gitignore_global
  $HOME/codes/dotfiles/cfgs/.zshrc
)

# transplant files to home
for file in ${FILES_TO_BE_TRANSPLANTED_TO_HOME[@]}; do
  echo "Transplanting $file to $HOME"
  # make symbolic link
  ln -sf $file $HOME
  echo "Made a symbolic link ($file -> $HOME)"
done

git config --global core.excludesfile $HOME/.gitignore_global
# set zsh as default shell
chsh -s $(which zsh)