#!/usr/bin/env bash
MSG=""
memfree=$(grep MemAvailable /proc/meminfo | awk '{print $2}') 
memtotal=$(grep MemTotal /proc/meminfo | awk '{print $2}')
memused=$((memtotal - memfree))
used_perc="$(bc -l <<< "scale=2; $memused * 100 / $memtotal")"
used_perc_int="${used_perc%%.*}"

# Only show the status if there is something interesting to show:
[ "$used_perc_int" -le 49 ] && exit 0
[ "$used_perc_int" -le 79 ] && MSG="🐏\x01$used_perc"
[ "$used_perc_int" -ge 80 ] && MSG="🐏\x03$used_perc"
[ "$used_perc_int" -ge 90 ] && MSG="🐏\x04$used_perc"

[ -z "$MSG" ] && exit 1

echo -e "\x01${MSG}%\x01"
