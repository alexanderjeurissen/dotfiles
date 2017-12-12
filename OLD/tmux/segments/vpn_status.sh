#!/bin/bash
run_segment() {
  ifconfig -lu | egrep -o "utun3" >/dev/null 2>&1
  vpn_status=$?

  if [ $vpn_status -eq 0 ]; then
    echo ""
  else
    echo "⌔ NO VPN!"
  fi
}
