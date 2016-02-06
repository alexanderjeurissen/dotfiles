#!/usr/bin/env bash

export TMUX_POWERLINE_DIR_HOME="$(dirname $0)"
export TMUX_POWERLINE_DIR_SEGMENTS="${TMUX_POWERLINE_DIR_HOME}/segments"
export TMUX_POWERLINE_DIR_LIB="${TMUX_POWERLINE_DIR_HOME}/lib"

source "${TMUX_POWERLINE_DIR_HOME}/config.sh"

print_powerline() {
  # The format of the segments is:

  # segment "segment_file_name" foreground background required_term_columns
  # double_segment "label" fg bg "segment_filename" fg bg required_term_columns

  # If the required amount of term columns isn't met then the segment will be
  # hidden
  double_segment "♫" brightgreen blue "now_playing" blue brightgreen 80
  double_segment "node" brightgreen yellow "node" yellow brightgreen 80
  double_segment "ruby" brightgreen red "ruby" red brightgreen 80
  double_segment "" brightgreen brightred "vcs_branch" brightred brightgreen
  segment "vcs_compare" black black #this is kind of a hack need to refactor
  double_segment "⊕" brightgreen green "vcs_staged" green brightgreen
  double_segment "+" brightgreen yellow "vcs_modified" yellow brightgreen
  double_segment "○" brightgreen white "vcs_others" white brightgreen
  exit 0
}

print_powerline "$1"
