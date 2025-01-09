#!/bin/bash
set -eu

# assume debian like distro, no check

./prerequisites.sh
./ssh.sh
./shell-experience.sh
./wsl.sh
./asdf.sh
./docker.sh