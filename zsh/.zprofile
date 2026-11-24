#
# ~/.config/zsh/.zprofile
#
# .zprofile acts as a startup script that executes whenever a login shell is initialized
# The primary purpose is to establish the environment in which your shell and its child
# processes operate.
#
# A login shell represents the initialization of a shell login environment.
# On macOS, terminal emulators commonly start login shells.
#

# Initialize Homebrew environment (package manager)
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

