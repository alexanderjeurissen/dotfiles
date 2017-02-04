# Displays the number of taskwarrior tasks in the inbox
run_segment() {
  tasks=`task +in +PENDING count`

  if [[ $tasks > 0 ]]; then
    echo " INBOX #[bold]${tasks}"
  fi
}
