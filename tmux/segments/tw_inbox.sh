# Displays the number of Maniphest tasks
run_segment() {
  cd ~/git/hackerone
  tasks=`arc tasks | egrep -o 'Normal | High | Unbreak Now' | wc -l | tr -d ' '`

  if [[ $tasks > 0 ]]; then
    echo " TASKS #[bold]${tasks}"
  fi
}
