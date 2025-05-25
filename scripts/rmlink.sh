#!/usr/bin/env bash

# Removes the original file of a symbolic link
rmlink() {
  local readlink_cmd
  readlink_cmd=$(command -v greadlink || command -v readlink)
  rm "$($readlink_cmd -f "$1")"
  unlink "$1"
}

rmlink "$1"
