#!/usr/bin/env bash
MSG=""
TEMP="$(sensors | awk '/Core 0/ {print $3}')"
[ -z "$TEMP" ] && exit 1

TEMP="${TEMP#+*}"
TEMP="${TEMP%%.*}"

# If the temperature is low, then don't show the status.
[ "$TEMP" -le 74 ] && exit 0
MSG="🌡 ${TEMP}°C"

echo " ${MSG} "
