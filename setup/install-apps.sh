#!/bin/bash
#
# ~/.config/setup/install-apps.sh
#
# This file should be the aggregator file which will invoke all setup scripts within this repo
#

set -euo pipefail

# --------------------------------------------------
# Application Installation
# --------------------------------------------------
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
if ! command -v brew >/dev/null; then
  echo 'Homebrew is required. Install it from https://brew.sh/ and follow its PATH instructions.' >&2
  exit 1
fi

exec brew bundle install --file="$script_dir/Brewfile" --no-upgrade

