#!/bin/bash
set -eu

# assume debian like distro, no check

./prerequisites.sh
./ssh.sh
./shell-experience.sh
./asdf.sh
./wsl.sh
./docker.sh