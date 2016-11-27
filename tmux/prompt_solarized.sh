#!/usr/bin/env bash

export TMUX_POWERLINE_DIR_HOME="$(dirname $0)"
export DEBUG_MODE=0 # enable this to test all segments
export DEBUG_VCS=0 # enable this to also show the vcs segments
source "${TMUX_POWERLINE_DIR_HOME}/config.sh"
get_pane_width

print_powerline() {
  # The format of the segments is:

  # segment "segment_file_name" foreground background min_pane_width
  # double_segment "label" fg bg "segment_filename" fg bg min_pane_width

  # If the required PANE_WIDTH isn't met then the segment will be
  # hidden
  if [ $DEBUG_MODE -ne 1 ]; then
    # double_segment "♫" white blue "now_playing" blue white 143
    powerline_segment "⬢" green "node" brightgreen black 113
    powerline_segment "" red "ruby" brightgreen black 113
    powerline_segment "" black "datetime" brightgreen black 113
  else
    source "${TMUX_POWERLINE_DIR_HOME}/debug_prompt.sh"
  fi

  exit 0
}

print_powerline "$1"
