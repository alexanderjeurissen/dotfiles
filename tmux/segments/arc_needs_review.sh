# Displays the number of maniphest diffs that need review
run_segment() {
  tmux_path=$(get_tmux_cwd)
  cd "$tmux_path"
  tasks=`arc list | grep 'Needs Review'`
  echo "N ${tasks}"
}
