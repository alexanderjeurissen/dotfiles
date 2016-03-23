#!/usr/bin/env bash

export TMUX_POWERLINE_DIR_HOME="$(dirname $0)"
export DEBUG_MODE=0 # enable this to test all segments
export DEBUG_VCS=0 # enable this to also show the vcs segments
source "${TMUX_POWERLINE_DIR_HOME}/config.sh"

print_powerline() {
get_pane_width
  # The format of the segments is:

  # segment "segment_file_name" foreground background min_pane_width
  # double_segment "label" fg bg "segment_filename" fg bg min_pane_width

  # If the required PANE_WIDTH isn't met then the segment will be
  # hidden
  if [ $DEBUG_MODE -ne 1 ]; then
    double_segment "♫" white blue "now_playing" blue white 143
    double_segment "js" white yellow "node" yellow white 113
    double_segment "rb" white red "ruby" red white 113
    double_segment "⎇" white brightred "vcs_branch" brightred white
    segment "vcs_compare" black black #this is kind of a hack need to refactor
    double_segment "⊕" white green "vcs_staged" green white
    double_segment "+" white yellow "vcs_modified" yellow white
    double_segment "○" white cyan "vcs_others" cyan white
  else
    source "${TMUX_POWERLINE_DIR_HOME}/debug_prompt.sh"
  fi

  exit 0
}

print_powerline "$1"
