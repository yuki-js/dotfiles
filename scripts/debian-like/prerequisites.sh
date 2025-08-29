#!/bin/bash
set -eu


# abort if superuser
if [ $(id -u) -eq 0 ]; then
  echo "Fatal error: This script must not be run as root"
  exit 1
fi
MAKE_ME_ROOT="sudo"
# assume debian like distro, no check

echo "Installing prerequisites..."

# install packages
echo "Installing packages..."
$MAKE_ME_ROOT apt-get update
$MAKE_ME_ROOT apt-get install --no-install-recommends -y \
  curl \
  git \
  jq \
  build-essential \
  zsh \
  openssh-server \
  ssh-import-id \
  ca-certificates \
  libssl-dev \
  zlib1g-dev \
  python3-launchpadlib
