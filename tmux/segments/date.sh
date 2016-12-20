# Displays the date in the following format:
#   DD/MM/YYYY

run_segment() {
  timeformat="`date +%d/%m/%y`"
  echo $timeformat
}
