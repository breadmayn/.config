#!/bin/bash
#
# ~/.config/setup/macOS-settings-apps.sh
#
# This file will manage and set the "System Settings.app" settings using command line
# mainly with `defaults write`
#
set -euo pipefail

# ensure running while logged in and on macOS
if [[ "$(uname -s)" != Darwin || "$EUID" == 0 ]]; then
    echo "Run this on macOS as the logged-in user." >&2
    exit 1
fi

# macOS dock ordering
DOCK_APPS=(Calendar Messages Discord Mail Safari Spotify Ghostty ChatGPT 'System Settings' Photos FaceTime Reminders Notes)

# given an app name, search through application dirs to find if it exists
find_app() {
    local name="$1" dir
    for dir in /System/Applications /System/Applications/Utilities /Applications "$HOME/Applications"; do
        if [[ -d "$dir/$name.app" ]]; then
            printf '%s\n' "$dir/$name.app"
            return
        fi
    done
    return 1
}

# ensure dockutil installed (brew install dockutil)
if ! command -v dockutil >/dev/null; then
    echo 'Dock ordering requires dockutil.' >&2
    exit 1
fi

# find all app paths
APP_PATHS=()
for app in "${DOCK_APPS[@]}"; do
    if ! path="$(find_app "$app")"; then
        printf 'Could not local %s.app. Install it before applying the Dock ordering.\n' "$app" >&2
        exit 1
    fi

    # append to APP_PATHS
    APP_PATHS+=("$path")
done

POWER_SETTINGS="$(/usr/bin/pmset -g custom)"

# --------------------------------------------------
# Writing defaults
# --------------------------------------------------
/usr/bin/defaults write com.apple.dock tilesize -int 49
/usr/bin/defaults write com.apple.dock mineffect -string scale
/usr/bin/defaults write com.apple.dock minimize-to-application -bool true
/usr/bin/defaults write com.apple.dock autohide -bool true
/usr/bin/defaults write com.apple.dock launchanim -bool false
/usr/bin/defaults write com.apple.dock show-recents -bool false

/usr/bin/defaults write com.apple.WindowManager EnableTilingByEdgeDrag -bool false
/usr/bin/defaults write com.apple.WindowManager EnableTopTilingByEdgeDrag -bool false
/usr/bin/defaults write com.apple.WindowManager EnableTilingOptionAccelerator -bool false

/usr/bin/defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
/usr/bin/defaults write com.apple.finder NewWindowTarget -string PfHm
/usr/bin/defaults write com.apple.finder ShowRecentTags -bool false
/usr/bin/defaults write -g AppleShowAllExtensions -bool true
/usr/bin/defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
/usr/bin/defaults write com.apple.finder WarnOnEmptyTrash -bool false
/usr/bin/defaults write com.apple.finder FXRemoveOldTrashItems -bool true
/usr/bin/defaults write com.apple.finder FXDefaultSearchScope -string SCcf

/usr/bin/defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
/usr/bin/defaults write -g NSAutomaticCapitalizationEnabled -bool false
/usr/bin/defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
/usr/bin/defaults write -g KeyRepeat -int 2
/usr/bin/defaults write -g InitialKeyRepeat -int 15

backup="$(mktemp -t macos-setup-dock)"
/usr/bin/defaults export com.apple.dock - > "$backup"
printf 'Dock preferences backed up to %s\n' "$backup"
if ! dockutil --remove all --no-restart; then
  echo 'Dock clearing failed. See the backup path above.' >&2
  exit 1
fi
for path in "${APP_PATHS[@]}"; do
  dockutil --add "$path" --no-restart
done
/usr/bin/killall Dock

# Apply the display timeout only on power profiles that need a change.
while read -r profile timeout; do
  case "$profile:$timeout" in
    -b:10|-c:30) continue ;;
    -b:*) /usr/bin/sudo /usr/bin/pmset -b displaysleep 10 ;;
    -c:*) /usr/bin/sudo /usr/bin/pmset -c displaysleep 30 ;;
  esac
done < <(/usr/bin/awk '
  /^Battery Power:/ { profile = "-b" }
  /^AC Power:/ { profile = "-c" }
  $1 == "displaysleep" && profile { print profile, $2 }
' <<< "$POWER_SETTINGS")

echo 'Preferences written. Log out and back in to reload any remaining settings.'

