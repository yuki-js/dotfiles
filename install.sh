#!/bin/sh

# WELCOME TO DOTFILES INSTALLER
# This script bootstraps a new machine with dotfiles
# Created by: @yuki-js
# Made for: @yuki-js

set -eu

# Variables
DOTFILES_REPO_URL="https://github.com/yuki-js/dotfiles.git"
OWNER="yuki-js"
BRANCH=${DF_BRANCH:-"master"}
DOTFILES_DIR="$HOME/codes/dotfiles"

# abort if superuser
if [ "$(id -u)" -eq 0 ]; then
  echo "Fatal error: This script must not be run as root"
  exit 1
fi
MAKE_ME_ROOT="sudo"

# Confirmation phase
if [ "${DF_SKIP_CONFIRM:-0}" -ne 1 ]; then
  echo "Hello! This script will install dotfiles to your machine."
  echo -n "What is your GitHub name? "
  read GHUSER

  # check if the GHUSER is OWNER
  if [ "$GHUSER" != "$OWNER" ]; then
    echo "Sorry, this script is not for you."
    exit 1
  fi

  # Confirm that the user wants to begin the installation
  echo "The dotfiles will be installed to $DOTFILES_DIR (if not exist, will be created)"
  echo -n "Do you want to begin the installation? (y/N) "
  read CONFIRM

  if [ "$CONFIRM" != "y" ]; then
    echo "Aborting installation"
    exit 1
  fi
fi

# Prerequisites installation phase
echo "Installing prerequisites..."
$MAKE_ME_ROOT apt-get update
$MAKE_ME_ROOT apt-get install -y git bash

# ensure `codes` directory
echo "Ensuring codes directory exists..."
mkdir -p "$HOME/codes"

# Re-install or update if dotfiles already exist
ACTION="${DF_REINSTALL:-}"
UPDATE_ONLY=0
if [ -d "$DOTFILES_DIR" ]; then
  echo "Existing dotfiles directory found at $DOTFILES_DIR"
  if [ "${DF_SKIP_CONFIRM:-0}" -ne 1 ] && [ -z "$ACTION" ]; then
    echo "Choose re-install behavior:"
    echo "  - reinstall: Remove the directory and clone fresh"
    echo "  - update   : Reset to origin/$BRANCH and clean"
    echo "  - abort    : Cancel"
    echo -n "Action [reinstall/update/abort] (default: update): "
    read ACTION
  fi
  ACTION=${ACTION:-update}
  case "$ACTION" in
    reinstall)
      echo "Removing existing directory..."
      rm -rf "$DOTFILES_DIR"
      ;;
    update)
      echo "Updating existing repository..."
      if [ -d "$DOTFILES_DIR/.git" ]; then
        cd "$DOTFILES_DIR"
        git fetch origin "$BRANCH" || git fetch --all --prune
        git reset --hard "origin/$BRANCH" || {
          echo "Branch $BRANCH not found on remote; falling back to default branch."
          DEFAULT_BRANCH=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p') || DEFAULT_BRANCH="master"
          git checkout -f "$DEFAULT_BRANCH" || true
          git reset --hard "origin/$DEFAULT_BRANCH" || true
        }
        git clean -fdx
        UPDATE_ONLY=1
      else
        echo "Directory exists but is not a git repo; performing clean reinstall..."
        rm -rf "$DOTFILES_DIR"
      fi
      ;;
    abort)
      echo "Aborting installation"
      exit 1
      ;;
    *)
      echo "Unknown action: $ACTION"
      exit 1
      ;;
  esac
fi

# Clone dotfiles repository when needed
if [ "$UPDATE_ONLY" -ne 1 ]; then
  echo "Cloning dotfiles repository..."
  cd "$HOME/codes"
  git clone "$DOTFILES_REPO_URL" -b "$BRANCH" --depth 1 dotfiles
fi

# Switch and run `scripts/entrypoint.sh`
echo "Switching to entrypoint.sh..."
cd "$DOTFILES_DIR"
bash scripts/entrypoint.sh

# Finish
echo "Installation completed."