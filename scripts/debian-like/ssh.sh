#!/bin/bash
set -eu

# abort if superuser
if [ $(id -u) -eq 0 ]; then
  echo "Fatal error: This script must not be run as root"
  exit 1
fi

# assume debian like distro, no check
echo "Setting SSH keys..."

# create .ssh directory
mkdir -p $HOME/.ssh
chmod 700 $HOME/.ssh

# create authorized_keys file via ssh-import-id
ssh-import-id gh:yuki-js
chmod 600 $HOME/.ssh/authorized_keys
