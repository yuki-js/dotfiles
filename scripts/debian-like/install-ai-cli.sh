#!/bin/bash
set -eu

# abort if superuser
if [ $(id -u) -eq 0 ]; then
  echo "Fatal error: This script must not be run as root"
  exit 1
fi
MAKE_ME_ROOT="sudo"

# Allow skip via env var (main gating is in entrypoint)
if [ "${DF_NO_AI_CLI:-0}" = "1" ]; then
  echo "Skip AI CLI installation (DF_NO_AI_CLI=1)."
  exit 0
fi

# Auto-skip when Node.js installation is disabled
if [ "${DF_NO_NODEJS:-0}" = "1" ]; then
  echo "Skip AI CLI installation (DF_NO_NODEJS=1)."
  exit 0
fi

echo "Installing AI CLI tools (OpenAI Codex, Anthropic Claude)..."

# Require npm
if ! command -v npm >/dev/null 2>&1; then
  echo -e "\e[31mnpm is not installed. Enable Node.js installation (DF_NO_NODEJS=0) or install npm manually.\e[m"
  echo -e "\a"
  exit 1
fi

# Fixed packages to install
PACKAGES=("@openai/codex" "@anthropic-ai/claude-code")


# Always use sudo for global installs
if ! $MAKE_ME_ROOT npm install -g --no-audit --no-fund "${PACKAGES[@]}"; then
  echo -e "\e[31mAI CLI installation failed.\e[m"
  echo "Tried to install: ${PACKAGES[*]}"
  echo -e "\a"
  exit 1
fi

echo "Installed global packages:"
npm ls -g --depth=0 || true

echo "Installing Google Antigravity CLI..."

curl -fsSL https://antigravity.google/cli/install.sh | bash

echo "AI CLI installation completed."