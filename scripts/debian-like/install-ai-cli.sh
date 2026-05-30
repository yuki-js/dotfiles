#!/bin/bash
set -eu

# abort if superuser
if [ $(id -u) -eq 0 ]; then
  echo "Fatal error: This script must not be run as root"
  exit 1
fi

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

echo "Installing AI CLI tools (OpenAI Codex, Antigravity CLI, Anthropic Claude)..."

INSTALLER_URL="https://antigravity.google/cli/install.sh"
INSTALLER_FILE="$(mktemp)"
trap 'rm -f "$INSTALLER_FILE"' EXIT

if ! command -v curl >/dev/null 2>&1; then
  echo -e "\e[31mcurl is not installed. Enable prerequisites installation or install curl manually.\e[m"
  echo -e "\a"
  exit 1
fi

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

echo "AI CLI installation completed."
