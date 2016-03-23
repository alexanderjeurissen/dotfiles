# run_segment() {
  # tmux_path=$(get_tmux_cwd)
  # cd "$tmux_path"

  read -r _ pane_width <<< $(stty size)
  echo $pane_width

  # modified_pane_width=$pane_width
  #
  # if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
  #   export TMUX_PANE_WIDTH=#{pane_width}
  # else
  #   export TMUX_PANE_WIDTH=#{pane_width}
  # fi
# }
