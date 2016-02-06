#!/usr/bin/env bash

export TMUX_POWERLINE_DIR_HOME="$(dirname $0)"
export TMUX_POWERLINE_DIR_SEGMENTS="${TMUX_POWERLINE_DIR_HOME}/segments"
export TMUX_POWERLINE_DIR_LIB="${TMUX_POWERLINE_DIR_HOME}/lib"

source "${TMUX_POWERLINE_DIR_HOME}/config.sh"

print_powerline() {
  double_segment "♫" brightgreen blue "now_playing" blue brightgreen 80
  double_segment "node" brightgreen yellow "node" yellow brightgreen 80
  double_segment "ruby" brightgreen red "ruby" red brightgreen 80
  double_segment "" brightgreen brightred "vcs_branch" brightred brightgreen
  segment "vcs_compare" black black
  double_segment "⊕" brightgreen green "vcs_staged" green brightgreen
  double_segment "+" brightgreen yellow "vcs_modified" yellow brightgreen
  double_segment "○" brightgreen white "vcs_others" white brightgreen
  exit 0
}

print_powerline "$1"
