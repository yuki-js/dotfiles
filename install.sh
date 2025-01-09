#!/bin/sh


# WELCOME TO DOTFILES INSTALLER
# This script bootstrap a new machine with dotfiles
# Created by: @yuki-js
# Made for: @yuki-js

set -eu

# Variables
DOTFILES_REPO_URL="https://github.com/yuki-js/dotfiles.git"
OWNER="yuki-js"
BRANCH=${DF_BRANCH:-"master"}

# abort if superuser
if [ $(id -u) -eq 0 ]; then
  echo "Fatal error: This script must not be run as root"
  exit 1
fi
MAKE_ME_ROOT="sudo"
# Confirmation phase
if [ "${DF_SKIP_CONFIRM:-0}" -ne 1 ]; then
  echo "Hello! This script will install dotfiles to your machine."
  echo -n "What is your GitHub name? "
  read GHUSER

  # check if the GHUSER is OWNER
  if [ "$GHUSER" != "$OWNER" ]; then
    echo "Sorry, this script is not for you."
    exit 1
  fi

  # Confirm that the user wants to begin the installation
  echo "The dotfiles will be installed to $HOME/codes/dotfiles (if not exist, will be created)"
  echo -n "Do you want to begin the installation? (y/N) "
  read CONFIRM

  if [ "$CONFIRM" != "y" ]; then
    echo "Aborting installation"
    exit 1
  fi
fi

# Prerequisites installation phase
echo "Installing prerequisites..."
$MAKE_ME_ROOT apt-get update
$MAKE_ME_ROOT apt-get install -y git bash

# make `codes` directory
echo "Making codes directory..."
mkdir -p $HOME/codes
cd $HOME/codes

# Clone dotfiles repository
echo "Cloning dotfiles repository..."
git clone $DOTFILES_REPO_URL -b $BRANCH --depth 1 dotfiles

# Switch and run `scripts/entrypoint.sh`
echo "Switching to entrypoint.sh..."
cd dotfiles
bash scripts/entrypoint.sh

# Finish