# Displays the number of maniphest diffs that have planned changes
run_segment() {
  cd ~/git/hackerone
  tasks=`arc list | grep 'Changes Planned' | wc -l | tr -d ' '`

  if [[ $tasks > 0 ]]; then
    echo " ${tasks}"
  fi
}
