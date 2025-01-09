#!/bin/bash
set -eu

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.15.0

# setup node.js with asdf
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf nodejs update-nodebuild
# install latest LTS version
NODE_LTS_EXACT_VERSION=`asdf nodejs resolve lts --latest-available`
asdf install nodejs $NODE_LTS_EXACT_VERSION
asdf global nodejs $NODE_LTS_EXACT_VERSION

# add settings to respect .node-version or .nvmrc in addition to .tool-versions
echo "legacy_version_file = yes" > ~/.asdfrc

# setup python with asdf
asdf plugin add python https://github.com/asdf-community/asdf-python.git
PYTHON_LATEST_VERSION=3.13.1
asdf install python $PYTHON_LATEST_VERSION
asdf global python $PYTHON_LATEST_VERSION
