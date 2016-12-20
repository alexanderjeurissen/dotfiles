# Displays the date and time in the following format:
#  HH:MM   DD/MM/YYYY

run_segment() {
  timeformat=" `date +%T`  `date +%d/%m/%y`"
  echo $timeformat
}
