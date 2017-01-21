# Displays the number of maniphest diffs that are acepted
run_segment() {
  return "A $(arc list | grep 'Accepted' | wc -l)"
}
