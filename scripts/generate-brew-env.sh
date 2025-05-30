#!/usr/bin/env bash
set -euo pipefail

: "${HOMEBREW_PREFIX:=/opt/homebrew}"
mkdir -p "$HOME/.cache"
"$HOMEBREW_PREFIX/bin/brew" shellenv > "$HOME/.cache/brew_env.zsh"

