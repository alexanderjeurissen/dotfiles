#!/usr/bin/env bash

export TMUX_POWERLINE_DIR_HOME="$(dirname $0)"
source "${TMUX_POWERLINE_DIR_HOME}/config.sh"
get_pane_width

print_powerline() {
  # The format of the segments is:
  # segment "segment_file_name" foreground background outer_most_segment? min_pane_width
  # If the required PANE_WIDTH isn't met then the segment will be hidden
  # if [[ $1 == "left" ]]; then
    # segment "arc_accepted" colour000 colour010 143
    # segment "arc_needs_review" colour000 colour009 143
    # segment "arc_changes_planned" colour000 colour009 143
  # else

    # segment "arc_accepted" colour000 colour010 143
    # segment "arc_needs_review" colour000 colour008 143
    # segment "arc_changes_planned" colour000 colour009 143
    segment "online" colour000 colour009 143
    segment "now_playing" colour000 colour009 143
    segment "uptime" colour000 colour010 143
    segment "datetime" colour000 colour011 143
    # segment "hostname" colour000 colour012 143
    segment "battery" colour000 colour012 143
  # fi

  exit 0
}

print_powerline "$1"
