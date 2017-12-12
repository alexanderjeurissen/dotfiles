#!/bin/bash

# Prints tmux session info.
# Assumes that [ -n "$TMUX"].

run_segment() {
  local session_name=$(tmux display-message -p '#S')
  local maniphest_task=$(__get_task_number)
  if [ "${session_name#*-}" != "$session_name" ];
  then
    first_part=${session_name%-*}
    second_part=${session_name#*-}
    initials=${first_part:0:1}${second_part:0:1}
    session_name=$initials
  else:
    pane_width=${TMUX_PANE_WIDTH}
    length=5

    if [ $pane_width -gt 100 ]; then
      echo ${session_name}
      length=${#${session_name}}
    fi

    session_name=${session_name:0:length}
  fi

  echo "#[bold] ${session_name}${maniphest_task}#[default]"
  return 0
}

__get_task_number() {
  tmux_path=$(get_tmux_cwd)
  cd "$tmux_path"
  local task_number=`git rev-parse --abbrev-ref HEAD | egrep -o 'T\d+'`

  if [[ -n $task_number ]]; then
    echo "  $task_number "
  fi
}
