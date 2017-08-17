#!/usr/bin/env bash

export TMUX_POWERLINE_DIR_HOME="$(dirname $0)"
source "${TMUX_POWERLINE_DIR_HOME}/config.sh"
get_pane_width

print_powerline() {
  # The format of the segments is:
  # segment "segment_file_name" foreground background outer_most_segment? min_pane_width
  # If the required PANE_WIDTH isn't met then the segment will be hidden
  if [[ $1 == "left" ]]; then
    flat_segment "session_info" 100 "left"
    # segment "session_info" colour015 colour01 100
    # segment "arc_accepted" colour014 colour000 120
    # segment "arc_needs_revision" colour014 colour000 120
    # segment "arc_needs_review" colour014 colour000 120
    # segment "arc_changes_planned" colour014 colour000 120
  else
    # segment "online" colour000 colour009 110
    # segment "now_playing" colour000 colour243 140
    # segment "uptime" colour000 colour010 143
    # flat_segment "vpn_status" 100 "right"
    flat_segment "online" 100 "right"
    flat_segment "pomodoro" 100 "right"
    flat_segment "datetime" 100 "right"
  fi

  exit 0
}

print_powerline "$1"
