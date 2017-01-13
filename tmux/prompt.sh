#!/usr/bin/env bash

export TMUX_POWERLINE_DIR_HOME="$(dirname $0)"
source "${TMUX_POWERLINE_DIR_HOME}/config.sh"
get_pane_width

print_powerline() {
  # The format of the segments is:
  # segment "segment_file_name" foreground background outer_most_segment? min_pane_width
  # If the required PANE_WIDTH isn't met then the segment will be hidden

  if [ $1 == 'left' ]; then
    segment "hostname" colour014 colour000 true 143
    segment "username" colour014 colour002 143
    segment "uptime" colour0015 colour001 143
    segment "online" colour0015 colour001 143
  # elif [ $1 == 'right' ]; then
  fi
  exit 0
}

print_powerline "$1"
