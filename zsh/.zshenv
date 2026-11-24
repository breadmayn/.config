#
# ~/.config/zsh/.zshenv
#
# This file contains essential environment configuration that should apply for every Zsh session
#
# This file is loaded on every zsh invocation and should include things such as essential env
# variables, and ZDOTDIR setup
#

# Configuration directory
export ZDOTDIR="$HOME/.config/zsh"

# XDG Base Directory Specification
# These XDG env vars are defined by the XDG Base Dir Specification - a standard that establishes
# where applications should store different types of files in a user's filesystem
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

