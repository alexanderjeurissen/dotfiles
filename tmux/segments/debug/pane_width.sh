run_segment() {
  read -r _ pane_width <<< $(stty size)
  echo $pane_width
}
