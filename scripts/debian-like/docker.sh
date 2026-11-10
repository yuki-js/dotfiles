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

# Docker publishes the Engine under one apt suite per distribution, and the
# suite names do not line up with the distributions in the wild: Ubuntu's
# codenames live under a separate path, a Debian newer than Docker's coverage
# has no suite at all, and Kali reports VERSION_CODENAME=kali-rolling. Read the
# identity from /etc/os-release, and keep a candidate only when Docker
# actually publishes a suite for it. The probe is per architecture, because
# Docker publishes some suites for some architectures only.
DOCKER_REPO_BASE="https://download.docker.com/linux/debian"
DOCKER_ARCH="$(dpkg --print-architecture)"
DOCKER_FALLBACK_CODENAME="trixie"

if [ -r /etc/os-release ]; then
    . /etc/os-release
    if [ "${ID:-}" = "ubuntu" ]; then
        DOCKER_REPO_BASE="${DOCKER_REPO_BASE%/debian}/ubuntu"
        DOCKER_FALLBACK_CODENAME="noble"
        [ -n "${UBUNTU_CODENAME:-}" ] && VERSION_CODENAME="$UBUNTU_CODENAME"
    fi
fi

CODENAME_CANDIDATES=()
[ -n "${VERSION_CODENAME:-}" ] && CODENAME_CANDIDATES+=("$VERSION_CODENAME")
CODENAME_CANDIDATES+=("$DOCKER_FALLBACK_CODENAME")

DOCKER_CODENAME=""
for candidate in "${CODENAME_CANDIDATES[@]}"; do
    if curl -fs -o /dev/null "$DOCKER_REPO_BASE/dists/$candidate/stable/binary-$DOCKER_ARCH/Packages"; then
        DOCKER_CODENAME="$candidate"
        break
    fi
    echo "No Docker apt suite for '$candidate', trying the next candidate..."
done

if [ -z "$DOCKER_CODENAME" ]; then
    echo -e "\e[31mNo Docker apt suite found for this distribution.\e[m"
    echo "Please check the official installation guide: https://docs.docker.com/engine/install/debian/"
    # bell
    echo -e "\a"
    exit 1
fi

echo "Installing Docker Engine for $DOCKER_CODENAME..."

# install docker from official instruction
$MAKE_ME_ROOT install -m 0755 -d /etc/apt/keyrings
$MAKE_ME_ROOT curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
$MAKE_ME_ROOT chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$DOCKER_ARCH signed-by=/etc/apt/keyrings/docker.asc] $DOCKER_REPO_BASE $DOCKER_CODENAME stable" | $MAKE_ME_ROOT tee /etc/apt/sources.list.d/docker.list 
$MAKE_ME_ROOT apt update
$MAKE_ME_ROOT apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y --no-install-recommends

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
