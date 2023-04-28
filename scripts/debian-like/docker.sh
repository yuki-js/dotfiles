#!/bin/sh
set -eu


# abort if superuser
if [ $(id -u) -eq 0 ]; then
  echo "Fatal error: This script must not be run as root"
  exit 1
fi
MAKE_ME_ROOT="sudo"
# assume debian like distro, no check

# install docker from official script
curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
$MAKE_ME_ROOT sh /tmp/get-docker.sh

# add user to docker group
$MAKE_ME_ROOT usermod -aG docker $USER

# install docker-compose
# Actually, Docker Compose is now bundled in Docker.

# If WSL2 and NVIDIA GPU is available, notify user to install NVIDIA Container Toolkit
if [ -f /proc/driver/nvidia/version ]; then
  echo "NVIDIA GPU is available"
  echo "Please install NVIDIA Container Toolkit"
fi
