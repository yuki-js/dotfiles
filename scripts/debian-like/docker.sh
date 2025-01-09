#!/bin/bash
set -u +e

# if DF_NO_DOCKER is present, and DF_NO_DOCKER is 1, skip docker installation
if [ -n "${DF_NO_DOCKER:-}" ] && [ "$DF_NO_DOCKER" = "1" ]; then
  echo "Skip docker installation"
  exit 0
fi

# abort if superuser
if [ $(id -u) -eq 0 ]; then
  echo -e "\e[31mFatal error: This script must not be run as root\e[m"
  exit 1
fi
MAKE_ME_ROOT="sudo"
# assume debian like distro, no check

echo "Installing Docker Engine..."

# install docker from official instruction
$MAKE_ME_ROOT install -m 0755 -d /etc/apt/keyrings
$MAKE_ME_ROOT curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
$MAKE_ME_ROOT chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian bookworm stable" | $MAKE_ME_ROOT tee /etc/apt/sources.list.d/docker.list 
$MAKE_ME_ROOT apt update
$MAKE_ME_ROOT apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# if install failed, abort with notification
if [ $? -ne 0 ]; then
  echo -e "\e[31mDocker installation failed\e[m"
  echo "Please check the official installation guide: https://docs.docker.com/engine/install/debian/"
  # bell
  echo -e "\a"
  exit 1
fi

# add user to docker group
$MAKE_ME_ROOT usermod -aG docker $USER

# install docker-compose
# Actually, Docker Compose is now bundled in Docker.

# If WSL2 and NVIDIA GPU is available, notify user to install NVIDIA Container Toolkit
if [ -f /proc/driver/nvidia/version ]; then
  echo "NVIDIA GPU is available"
  echo "Please install NVIDIA Container Toolkit"
  # bell
  echo -e "\a"
fi
