# Displays the number of maniphest diffs that have planned changes
run_segment() {
  tmux_path=$(get_tmux_cwd)
  cd "$tmux_path"
  tasks=$(arc list | grep 'Changes Planned' | wc -l)
  echo "$tasks"
}
