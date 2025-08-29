#!/bin/bash
set -eu

# Install the latest Node.js from NodeSource (recommended for latest LTS)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Node.js version:"
node -v