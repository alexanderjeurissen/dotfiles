#!/bin/bash
run_segment() {
  wget -q --spider https://github.com

  if [ $? -eq 0 ]; then
    sleep 10s
    if curl --silent --head https://hackerone.com/ |egrep "20[0-9] OK" >/dev/null
    then
      echo ""
    else
      echo "  H1 DOWN!"
    fi
  else
    echo "⌔ WIFI!"
  fi
}
