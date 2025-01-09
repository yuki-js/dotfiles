#!/bin/bash
set -eu


# abort if superuser
if [ $(id -u) -eq 0 ]; then
  echo "Fatal error: This script must not be run as root"
  exit 1
fi
MAKE_ME_ROOT="sudo"
# assume debian like distro, no check

# if not wsl2, pass
if [ ! -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
  echo "Not a WSL2, skipping"
  exit 0
fi

echo "Making WSL environment better..."

# cp /etc/wsl.conf
# backup if already exist
if [ -f /etc/wsl.conf ]; then
  $MAKE_ME_ROOT cp -f /etc/wsl.conf /etc/wsl.conf.bak
fi
$MAKE_ME_ROOT cp -f $HOME/codes/dotfiles/cfgs/wsl.conf /etc/wsl.conf
