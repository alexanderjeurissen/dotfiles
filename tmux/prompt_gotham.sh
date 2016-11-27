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
    double_segment "♫" black blue "now_playing" black brightblue 143
    double_segment "js" black yellow "node" black brightyellow 113
    double_segment "rb" black red "ruby" black brightred 113
    double_segment "⎇" black brightred "vcs_branch" black brightred
    segment "vcs_compare" black black #this is kind of a hack need to refactor
    double_segment "⊕" black green "vcs_staged" black brightgreen
    double_segment "+" black yellow "vcs_modified" black brightyellow
    double_segment "○" black cyan "vcs_others" black brightcyan
  else
    source "${TMUX_POWERLINE_DIR_HOME}/debug_prompt.sh"
  fi

  exit 0
}

print_powerline "$1"
