run_segment() {
  read -r _ _ _ _ package _ <<< $(~/git/hackerone/bin/doctor | grep 'Wrong version')
  echo "$package"
}
