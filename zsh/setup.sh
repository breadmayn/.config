#!/usr/bin/env bash

MY_CONFIG_PATH="$HOME/.config/zsh"
ZSH_CONFIG_PATH="$HOME"

CONFIG_NAME=".zshrc"

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# remove the default zshrc file
rm -rf "$ZSH_CONFIG_PATH/$CONFIG_NAME"

# symlink this config file to the default config path
ln -sfn "$MY_CONFIG_PATH/$CONFIG_NAME" "$ZSH_CONFIG_PATH"

