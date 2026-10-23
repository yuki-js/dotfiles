#!/bin/bash
set -eu

# abort if superuser
if [ $(id -u) -eq 0 ]; then
  echo "Fatal error: This script must not be run as root"
  exit 1
fi
MAKE_ME_ROOT="sudo"
# assume debian like distro, no check
if [ "${DF_NO_SSH_IMPORT:-0}" = "1" ]; then
  echo "Skip SSH key import."
  exit 0
fi

echo "Setting SSH keys..."

# create .ssh directory
mkdir -p $HOME/.ssh
chmod 700 $HOME/.ssh

# create authorized_keys file via ssh-import-id
ssh-import-id gh:yuki-js
chmod 600 $HOME/.ssh/authorized_keys

# if DF_NO_SSH_HARDENING is present, and DF_NO_SSH_HARDENING is 1, skip sshd config installation
if [ -n "${DF_NO_SSH_HARDENING:-}" ] && [ "$DF_NO_SSH_HARDENING" = "1" ]; then
  echo "Skip sshd config installation"
  exit 0
fi

# install recommended sshd settings as a drop-in config
SSHD_CONF_DIR="/etc/ssh/sshd_config.d"
$MAKE_ME_ROOT mkdir -p $SSHD_CONF_DIR
$MAKE_ME_ROOT cp -f $HOME/codes/dotfiles/cfgs/sshd/10-recommended-settings.conf $SSHD_CONF_DIR/10-recommended-settings.conf

# validate sshd config and restart sshd
$MAKE_ME_ROOT sshd -t
$MAKE_ME_ROOT systemctl restart ssh
