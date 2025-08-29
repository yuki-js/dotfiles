#!/bin/bash
set -eu

# Install Node.js unless DF_NO_NODEJS=1
if [ "${DF_NO_NODEJS:-0}" != "1" ]; then
  ./install-latest-nodejs.sh
fi

# Install Python unless DF_NO_PYTHON=1
if [ "${DF_NO_PYTHON:-0}" != "1" ]; then
  ./install-latest-python.sh
fi