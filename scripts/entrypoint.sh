#!/bin/sh
set -eu


# abort if superuser
if [ $(id -u) -eq 0 ]; then
  echo "Fatal error: This script must not be run as root"
  exit 1
fi
MAKE_ME_ROOT="sudo"

# Environment prerequisites check
echo "Checking environment prerequisites..."
# OS must be Linux
if [ "$(uname)" != "Linux" ]; then
  echo "Sorry, this script is only for Linux"
  exit 1
fi

# Detect distro
DISTRO_FAMILY=
# First, detect Debian like
# look at ID_LIKE
if [ -f /etc/os-release ]; then
  . /etc/os-release
  if [ -n "$ID_LIKE" && "$ID_LIKE" = "debian" ]; then
    DISTRO_FAMILY="debian"
  fi
fi

# switch by distro family
case $DISTRO_FAMILY in
  "debian" )
    echo "Detected Debian like distro"
    cd $HOME/codes/dotfiles/scripts/debian-like
    ./entrypoint.sh
    ;;
  * )
    echo "Sorry, this script is only for Debian like distro"
    exit 1
    ;;
esac




