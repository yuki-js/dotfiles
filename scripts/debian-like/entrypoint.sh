#!/bin/bash
set -eu

# assume debian like distro, no check

# Run interactive questions and load answers
./question.sh
if [ -f /tmp/dotfiles_question_result ]; then
  . /tmp/dotfiles_question_result
fi

./prerequisites.sh
./ssh.sh
./shell-experience.sh
./wsl.sh

# Docker install
if [ "${DF_NO_DOCKER:-0}" = "0" ]; then
  ./docker.sh
else
  echo "Skip Docker installation."
fi

# Node.js install
if [ "${DF_NO_NODEJS:-0}" = "0" ]; then
  ./install-latest-nodejs.sh
else
  echo "Skip Node.js installation."
fi

# Python install
if [ "${DF_NO_PYTHON:-0}" = "0" ]; then
  ./install-latest-python.sh
else
  echo "Skip Python installation."
fi

echo "Installation completed! Please restart your shell."