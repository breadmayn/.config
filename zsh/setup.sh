#
# ~/.config/zsh/setup.sh
#
# This file will correctly setup/hook in the zsh configuration specified in ~/.config/zsh/
#

#!/bin/bash

set -euo pipefail

SOURCE="$HOME/.config/zsh/.zshenv"
TARGET="$HOME/.zshenv"

# Initialize Homebrew environment.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install shell dependencies from Homebrew
brew bundle --file="$HOME/.config/zsh/Brewfile" --no-upgrade

# Verify that the source configuration exists
if [[ ! -f "$SOURCE" ]]; then
    echo "Error: Missing $SOURCE"
    exit 1
fi

# Skip if the correct symlink already exists
if [[ -L "$TARGET" && "$TARGET" -ef "$SOURCE" ]]; then
    echo "Zsh configuration already linked."
    exit 0
fi

# Prevent overwriting an existing configuration
if [[ -e "$TARGET" || -L "$TARGET" ]]; then
    echo "Error: $TARGET already exists."
    exit 1
fi

# Create the symlink
ln -s "$SOURCE" "$TARGET"

echo "Zsh configuration linked successfully"

