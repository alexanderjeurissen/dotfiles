#!/usr/bin/env bash

brew update
brew prune
brew upgrade
for x in $(brew list -1); do brew unlink $x; brew link $x; done
