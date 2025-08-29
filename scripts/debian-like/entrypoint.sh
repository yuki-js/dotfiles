#!/bin/bash
set -eu

# assume debian like distro, no check

./prerequisites.sh
./ssh.sh
./shell-experience.sh
./wsl.sh
./docker.sh
./install-latest-languages.sh

echo "Installation completed! Please restart your shell."