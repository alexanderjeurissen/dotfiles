#!/usr/bin/env bash

set -euo pipefail

TERMDIR="$(dirname "$0")/../terminfo"

for file in "$TERMDIR"/*.terminfo "$TERMDIR"/*.tic; do
  [ -e "$file" ] || continue
  tic -x -o "$HOME/.terminfo" "$file"
done
