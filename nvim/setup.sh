#!/usr/bin/env bash

set -e

NVIM_CONFIG="$HOME/.config/nvim"

### ENSURE SSH KEYS ARE SETUP BEFORE RUNNING THIS SCRIPT ###

# trust github's host key so lazy won't error out when loading plugin's through git ssh cloning
ssh-keygen -F github.com >/dev/null || ssh-keyscan github.com >> "$HOME/.ssh/known_hosts"

# install brew dependencies
brew bundle --file="$NVIM_CONFIG/Brewfile"

# install nvim plugins before first load
nvim --headless "+Lazy! restore" +qa

