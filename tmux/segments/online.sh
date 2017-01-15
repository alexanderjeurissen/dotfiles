#!/bin/bash
run_segment() {
  nc -z 8.8.8.8 53  >/dev/null 2>&1
  online=$?

  if [ $online -eq 0 ]; then
    echo ""
  else
    echo "⌔ OFFLINE!"
  fi
}
