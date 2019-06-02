#!/bin/sh

if ! [ -x "$(command -v brew)" ]; then
  echo 'Error: brew is not installed.' >&2
  exit 1
fi
brew install python
pip3 install virtualenv

echo "Installed! Type 'virtualenv projname && cd projname && source bin/activate'"
