#!/usr/bin/env bash

# Removes the original file of a symbolic link
rmlink() {
  rm "$(greadlink -f "$1")"
  unlink "$1"
}

rmlink "$1"
