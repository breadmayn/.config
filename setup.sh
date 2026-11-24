#!/bin/bash
#
# ~/.config/setup.sh
#
# This file is the top-level aggregator of all the other setup scripts in this repo.
# This file allows us to only need to run a single setup command to get the following:
#   - developer cli tools (Apple)
#   - Homebrew
#   - application installations
#   - macOS settings
#   - dev env setup (ghostty, tmux, zsh, nvim)
#
set -euo pipefail

config_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Keep Homebrew available to every setup module.
source "$config_dir/setup/bootstrap.sh"
bootstrap_dependencies

/bin/bash "$config_dir/setup/install-apps.sh"
/bin/bash "$config_dir/zsh/setup.sh"

# The macOS settings script needs Ghostty installed for the Dock.
/bin/bash "$config_dir/ghostty/setup.sh"
/bin/bash "$config_dir/setup/macOS-settings.sh"

/bin/bash "$config_dir/tmux/setup.sh"
/bin/bash "$config_dir/nvim/setup.sh"
