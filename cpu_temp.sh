#!/usr/bin/env bash
OS=$(uname)

MSG=""
if [ "$OS" = "Linux" ]; then
	TEMP=$(sensors | awk '/Core 0/ {print $3}')
elif [ "$OS" = "OpenBSD" ]; then
	TEMP=$(sysctl -n hw.sensors.cpu0.temp0 | cut -d'.' -f 1)
fi

[ -z "$TEMP" ] && exit 1

TEMP="${TEMP#+*}"
TEMP="${TEMP%%.*}"

# If the temperature is low, then don't show the status.
[ "$TEMP" -le 74 ] && exit 0
MSG="🌡 ${TEMP}°C"

echo " ${MSG} "
