#!/usr/bin/env bash
MSG=""
TEMP="$(sensors | awk '/Core 0/ {print $3}')"
TEMP="${TEMP#+*}"
TEMP="${TEMP%%.*}"

# If the temperature is low, then don't show the status.
[ "$TEMP" -le 74 ] && exit 0
[ "$TEMP" -ge 75 ] && MSG="\x03🌡 ${TEMP}°C"
[ "$TEMP" -ge 85 ] && MSG="\x04🌡 ${TEMP}°C"

[ -z "$MSG" ] && exit 1
echo -e "${MSG}\x01"
