#!/usr/bin/env bash

MY_CONFIG_PATH="$HOME/.config/ghostty"
GHOSTTY_CONFIG_PATH="$HOME/Library/Application Support/com.mitchellh.ghostty"

CONFIG_NAME="config.ghostty"

# first ensure ghostty is installed
brew bundle --file="$MY_CONFIG_PATH/Brewfile"

# remove default ghostty config file
rm -rf "$GHOSTTY_CONFIG_PATH/$CONFIG_NAME"

# add symlink to our config file"
ln -sfn "$MY_CONFIG_PATH/$CONFIG_NAME" "$GHOSTTY_CONFIG_PATH"

