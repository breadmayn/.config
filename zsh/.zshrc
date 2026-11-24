#
# ~/.config/zsh/.zshrc
#
# Unlike .zshenv and .zprofile, .zshrc is used to configure your interactive shell
#

# Propmt initialization
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi


# --------------------------------------------------
# Completion
# --------------------------------------------------

# Make Zsh's builtin completion initialization function available
autoload -Uz compinit
# Initializes the completion system
compinit

# Enables an interactive completion menu navigatable with arrow keys
zstyle ':completion:*' menu select
# Makes completion case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'


# --------------------------------------------------
# History
#
# History related keymaps
# <CTRL + r>: search for prev match in command history
# <CTRL + s>: search for a match forward
# <CTRL + G>: cancel history search
# --------------------------------------------------

# HISTFILE is the location of persistent command history
# HISTSIZE is the maximum commands retained in memory
# SAVEHIST is maximum commands saved to disk
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=50000

mkdir -p "${HISTFILE:h}"

# HIST_IGNORE_ALL_DUPS Removes older duplicate commands
# HIST_FIND_NO_DUPS Skips duplicate commands when searching history
# HIST_IGNORE_SPACE Doesn't record commands beginning with a space
# HIST_REDUCE_BLANKS Removes unnecessary whitespace from saved commands
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# bindkey enables incremental reverse history search with <CTRL + r>
bindkey '^R' history-incremental-search-backward


# --------------------------------------------------
# Keyboard navigation
# --------------------------------------------------

# Use Emacs-style keybindings.
bindkey -e

