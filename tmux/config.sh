#!/usr/bin/env bash
export TMUX_POWERLINE_DIR_SEGMENTS="${TMUX_POWERLINE_DIR_HOME}/segments"

get_pane_width() {
  local pane_width="$(tmux display-message -p '#{pane_width}')"
  export TMUX_PANE_WIDTH=$pane_width
}

# Get the current path in the segment.
get_tmux_cwd() {
  local env_name=$(tmux display -p "TMUX_PWD_#D" | tr -d %)
  local env_val=$(tmux show-environment -g "$env_name")
  # The version below is still quite new for tmux. Uncomment this in the future :-)
  #local env_val=$(tmux show-environment "$env_name" 2>&1)

  if [[ ! $env_val =~ "unknown variable" ]]; then
    local tmux_pwd=$(echo "$env_val" | sed 's/^.*=//')
    echo "$tmux_pwd"
  fi
}

DEFAULT_BACKGROUND_COLOR=255
DEFAULT_FOREGROUND_COLOR=0

segment() {
  local segment="$1"
  local seg_fg="$2"
  local seg_bg="$3"
  local collapse_width="$4"

  source "${TMUX_POWERLINE_DIR_HOME}/segments/${segment}.sh"
  local result=$(run_segment)

  local output="#[fg=${seg_fg}, bg=${seg_bg}] ${result} #[bg=default]"

  local exit_code="$?"
  unset -f run_segment

  # Show error when exit code != 0
  if [ "$exit_code" -ne 0 ]; then
    echo "Segment '${segment}' exited with code ${exit_code}. Aborting."
    exit 1
  fi

  # don't show output if the result is empty
  # or if the screen is small and has autohide enabled
  if [ $TMUX_PANE_WIDTH -lt $collapse_width ]; then
    local display="hidden"
  fi

  if [[ -z "${result// }" || $display == "hidden" ]]; then
    echo -n ""
  else
    echo -ne "${output}"
  fi
}

powerline_segment() {
  local segment="$1"
  local seg_fg="$2"
  local seg_bg="$3"
  local left_most="$4"
  local collapse_width="$5"

  local output = ""

  source "${TMUX_POWERLINE_DIR_HOME}/segments/${segment}.sh"
  local result=$(run_segment)

  local powerline_suffix=" #[fg=${seg_bg}, bg=default]"

  if [[ "$left_most" -ne true ]]; then
    local powerline_prefix="#[fg=default, bg=${seg_bg}]"
  fi

  output="${powerline_prefix}#[fg=${seg_fg}, bg=${seg_bg}] ${result}${output}${powerline_suffix}"

  local exit_code="$?"
  unset -f run_segment

  # Show error when exit code != 0
  if [ "$exit_code" -ne 0 ]; then
    echo "Segment '${segment}' exited with code ${exit_code}. Aborting."
    exit 1
  fi

  # don't show output if the result is empty
  # or if the screen is small and has autohide enabled
  if [ $TMUX_PANE_WIDTH -lt $7 ]; then
    local display="hidden"
  fi

  if [[ -z "${result// }" || $display == "hidden" ]]; then
    echo -n ""
  else
    echo -ne "${output}"
  fi
}

# Shell Configuration
ostype() { echo $OSTYPE | tr '[A-Z]' '[a-z]'; }

export SHELL_PLATFORM='unknown'

case "$(ostype)" in
  *'linux'* ) SHELL_PLATFORM='linux'  ;;
  *'darwin'*  ) SHELL_PLATFORM='osx'    ;;
  *'bsd'*   ) SHELL_PLATFORM='bsd'    ;;
esac

shell_is_linux() { [[ $SHELL_PLATFORM == 'linux' || $SHELL_PLATFORM == 'bsd' ]]; }
shell_is_osx()   { [[ $SHELL_PLATFORM == 'osx' ]]; }
shell_is_bsd()   { [[ $SHELL_PLATFORM == 'bsd' || $SHELL_PLATFORM == 'osx' ]]; }

export -f shell_is_linux
export -f shell_is_osx
export -f shell_is_bsd
