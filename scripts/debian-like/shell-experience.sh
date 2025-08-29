#!/bin/bash
set -eu


# abort if superuser
if [ $(id -u) -eq 0 ]; then
  echo "Fatal error: This script must not be run as root"
  exit 1
fi
MAKE_ME_ROOT="sudo"
# assume debian like distro, no check

echo "Setting up shell experience..."

FILES_TO_BE_TRANSPLANTED_TO_HOME=(
  $HOME/codes/dotfiles/cfgs/.zshrc
)

# transplant files to home
for file in ${FILES_TO_BE_TRANSPLANTED_TO_HOME[@]}; do
  echo "Transplanting $file to $HOME"
  # make symbolic link
  ln -sf $file $HOME
  echo "Made a symbolic link ($file -> $HOME)"
done
# create .hushlogin if not exists
if [ ! -f "$HOME/.hushlogin" ]; then
  touch "$HOME/.hushlogin"
fi

# set zsh as default shell
sudo chsh -s $(which zsh) $(whoami)

# git configs
git config --global user.email "me@aoki.app"
git config --global user.name "yuki-js"

# if XDG_CONFIG_HOME is set:
if [ -n "${XDG_CONFIG_HOME:-}" ]; then
  # create a symbolic link to $XDG_CONFIG_HOME
  mkdir -p $XDG_CONFIG_HOME/git
  ln -sf $HOME/codes/dotfiles/cfgs/.gitignore_global $XDG_CONFIG_HOME/git/ignore
else
  # create a symbolic link to $HOME
  mkdir -p $HOME/.config/git
  ln -sf $HOME/codes/dotfiles/cfgs/.gitignore_global $HOME/.config/git/ignore
fi