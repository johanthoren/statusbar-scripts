#!/usr/bin/env bash
con="$(bluetoothctl info E4:90:FD:29:5A:DC | grep Connected | cut -d ' ' -f 2)"
[ "$con" = "yes" ] || exit 0
echo " 🎧 "
