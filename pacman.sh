#!/bin/sh
UPDATES="$(pacman -Qu | grep -Fcv '[ignored]')"
[ "$UPDATES" -eq 0 ] && exit 0

echo " 📦 $UPDATES "
