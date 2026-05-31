#!/bin/bash
set -eu

# NOTE:
# Branch selection (DF_BRANCH) must be set as an environment variable before running install.sh.
# To skip all questions, set DF_SKIP_CONFIRM=1 and provide DF_NO_DOCKER, DF_NO_NODEJS, DF_NO_PYTHON as environment variables if needed.

export LANG=C
export LC_ALL=C

QUESTION_RESULT_FILE="/tmp/dotfiles_question_result"

if [ "${DF_SKIP_CONFIRM:-0}" = "1" ]; then
  : > "$QUESTION_RESULT_FILE"
  echo "DF_NO_DOCKER=${DF_NO_DOCKER:-0}" >> "$QUESTION_RESULT_FILE"
  echo "DF_NO_NODEJS=${DF_NO_NODEJS:-0}" >> "$QUESTION_RESULT_FILE"
  echo "DF_NO_PYTHON=${DF_NO_PYTHON:-0}" >> "$QUESTION_RESULT_FILE"
  echo "Questions skipped (auto mode)."
  exit 0
fi

while :; do
  : > "$QUESTION_RESULT_FILE"

  # Docker
  echo "Do you want to install Docker? (y/n) [y]"
  read install_docker
  install_docker=${install_docker:-y}
  if [ "$install_docker" = "y" ]; then
    echo "DF_NO_DOCKER=0" >> "$QUESTION_RESULT_FILE"
  else
    echo "DF_NO_DOCKER=1" >> "$QUESTION_RESULT_FILE"
  fi

  # Node.js
  echo "Do you want to install Node.js? (y/n) [y]"
  read install_nodejs
  install_nodejs=${install_nodejs:-y}
  if [ "$install_nodejs" = "y" ]; then
    echo "DF_NO_NODEJS=0" >> "$QUESTION_RESULT_FILE"
  else
    echo "DF_NO_NODEJS=1" >> "$QUESTION_RESULT_FILE"
  fi

  # Python
  echo "Do you want to install Python? (y/n) [y]"
  read install_python
  install_python=${install_python:-y}
  if [ "$install_python" = "y" ]; then
    echo "DF_NO_PYTHON=0" >> "$QUESTION_RESULT_FILE"
  else
    echo "DF_NO_PYTHON=1" >> "$QUESTION_RESULT_FILE"
  fi

  # Show summary and confirm
  echo ""
  echo "===== Setup Summary ====="
  echo "  Docker:   $install_docker"
  echo "  Node.js:  $install_nodejs"
  echo "  Python:   $install_python"
  echo "========================="
  echo "Is this configuration OK? (y/n) [y]"
  read confirm
  confirm=${confirm:-y}
  if [ "$confirm" = "y" ]; then
    break
  fi
  echo "Let's try again."
done

echo "All questions completed."