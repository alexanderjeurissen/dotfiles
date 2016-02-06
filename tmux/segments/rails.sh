# Source lib to get the function get_tmux_pwd
source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"

run_segment() {
   tmux_path=$(get_tmux_cwd)

   cd "$tmux_path"
   echo $(rails version-name)
}
