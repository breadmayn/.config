#!/bin/bash
#
# ~/.config/setup/bootstrap.sh
#
# This file bootstraps the main dependencies required for any real setup to run realted to my
# macOS configuration as well as dev environment setup.
#

log() {
    printf '[bootstrap] %s\n' "$*"
}

die() {
    log "$*" >&2
    exit 1
}

developer_tools_ready() {
    xcode-select -p >/dev/null 2>&1 &&
        xcrun --find clang >/dev/null 2>&1 &&
        xcrun --find git >/dev/null 2>&1
}

install_xcode_cli() {
    developer_tools_ready && return 0

    log 'Approve the Command Line Tools installer in the macOS dialog.'
    if ! xcode-select --install; then
        log 'Could not open a new installer. Complete any installation already in progress.'
    fi

    local deadline=$((SECONDS + 3600))
    until developer_tools_ready; do
        (( SECONDS < deadline )) || die 'Timed out waiting for Command Line Tools.'
        sleep 5
    done
}

find_brew() {
    command -v brew && return
    local candidate
    for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew; do
        if [[ -x "$candidate" ]]; then
            printf '%s\n' "$candidate"
            return
        fi
    done
    return 1
}

install_homebrew() {
    local brew_bin installer shell_environment
    if ! brew_bin="$(find_brew)"; then
        log 'Installing Homebrew.'
        installer="$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        /bin/bash -c "$installer"
        brew_bin="$(find_brew)" || die 'Homebrew was not found after installation.'
    fi

    shell_environment="$("$brew_bin" shellenv bash)"
    eval "$shell_environment"
}

bootstrap_dependencies() {
    [[ "$(uname -s)" == Darwin && "$EUID" -ne 0 ]] ||
        die 'Run this on macOS as your normal user.'

    install_xcode_cli
    install_homebrew
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    set -euo pipefail
    bootstrap_dependencies
fi

