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

echo "Installing AI CLI tools (OpenAI Codex, Google Antigravity, Anthropic Claude Code)..."

INSTALLER_URL="https://antigravity.google/cli/install.sh"
INSTALLER_FILE="$(mktemp)"
trap 'rm -f "$INSTALLER_FILE"' EXIT

if ! curl -fsSL "$INSTALLER_URL" -o "$INSTALLER_FILE"; then
  echo -e "\e[31mAI CLI installation failed.\e[m"
  echo "Failed to download: $INSTALLER_URL"
  echo -e "\a"
  exit 1
fi

if ! bash "$INSTALLER_FILE"; then
  echo -e "\e[31mAI CLI installation failed.\e[m"
  echo "Failed to execute: $INSTALLER_URL"
  echo -e "\a"
  exit 1
fi

for package in @openai/codex @anthropic-ai/claude-code; do
  if ! $MAKE_ME_ROOT npm install -g --no-audit --no-fund "$package"; then
    echo -e "\e[31mAI CLI installation failed.\e[m"
    echo "Failed to install: $package"
    echo -e "\a"
    exit 1
  fi
done

echo "AI CLI installation completed."
