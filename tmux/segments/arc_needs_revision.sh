# Displays the number of maniphest diffs that need review
run_segment() {
  cd ~/git/hackerone
  tasks=`arc list | grep 'Needs Revision' | wc -l | tr -d ' '`

  if [[ $tasks > 0 ]]; then
    echo " ${tasks}"
  fi
}
