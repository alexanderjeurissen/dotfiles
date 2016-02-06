
run_segment() {
   version_number=$(node -v)
   tmux_path=$(get_tmux_cwd)

   cd "$tmux_path"
   echo "${version_number:1:10}"
}
