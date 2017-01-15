#!/usr/bin/env bash

export TMUX_POWERLINE_DIR_HOME="$(dirname $0)"
source "${TMUX_POWERLINE_DIR_HOME}/config.sh"
get_pane_width

print_powerline() {
  # The format of the segments is:
  # segment "segment_file_name" foreground background outer_most_segment? min_pane_width
  # If the required PANE_WIDTH isn't met then the segment will be hidden
  segment "online" colour000 colour009 143
  segment "now_playing" colour000 colour009 143
  segment "uptime" colour000 colour011 143
  segment "datetime" colour000 colour012 143
  # segment "hostname" colour000 colour012 143

  exit 0
}

print_powerline "$1"
