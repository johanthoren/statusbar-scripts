#!/usr/bin/env bash
MSG=""
memfree=$(grep MemAvailable /proc/meminfo | awk '{print $2}') 
memtotal=$(grep MemTotal /proc/meminfo | awk '{print $2}')
memused=$((memtotal - memfree))
used_perc="$(bc -l <<< "scale=2; $memused * 100 / $memtotal")"
used_perc_int="${used_perc%%.*}"

# Only show the status if there is something interesting to show:
[ "$used_perc_int" -le 49 ] && exit 0

[ -z "$used_perc" ] && exit 1

MSG="🐏 $used_perc"

echo " ${MSG}% "
