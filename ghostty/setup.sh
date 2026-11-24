#!/usr/bin/env bash
set -euo pipefail

MY_CONFIG_PATH="$HOME/.config/ghostty"

# Initialize Homebrew independently of shell configuration.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install Ghostty dependencies.
brew bundle --file="$MY_CONFIG_PATH/Brewfile" --no-upgrade

