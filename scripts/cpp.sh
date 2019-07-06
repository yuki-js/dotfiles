#!/bin/sh

if ! [ -x "$(command -v brew)" ]; then
  echo 'Error: brew is not installed.' >&2
  exit 1
fi
brew install gcc
brew install boost

echo "Installed! Create symlink of /usr/local/bin/gcc & move lib to the appropriate place"
