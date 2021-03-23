#!/usr/bin/env bash
STATUS="$(ifconfig trunk0 | awk '/status:/ {print $2}')"

# Only show the status if there is something interesting to show.
[ "$STATUS" = "active" ] && exit 0

echo " trunk0: ${STATUS} "
