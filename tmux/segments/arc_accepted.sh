# Displays the number of maniphest diffs that are acepted
run_segment() {
  cd ~/git/hackerone
  tasks=`arc list | grep 'Accepted' | wc -l | tr -d ' '`

  if [[ $tasks > 0 ]]; then
    echo " ${tasks}"
  fi
}
