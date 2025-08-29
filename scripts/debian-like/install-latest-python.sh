#!/bin/bash
set -eu

# Install the latest Python 3 available in apt
sudo apt-get update
sudo apt-get install -y python3 python3-pip

echo "Python version:"
python3 --version