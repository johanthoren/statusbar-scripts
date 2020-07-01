#!/usr/bin/env bash
INET="$(ip addr | grep 'inet\ ')"
WLP="$(grep wlp <<< "$INET")"

WLP_IP_CUT="${WLP#*inet\ }"
WLP_IP="${WLP_IP_CUT%%\/*}"

MSG="📡"
#[ -n "$WLP_IP" ] && MSG="\x01📶"

# Only show the status if there is something interesting to show.
[ -n "$WLP_IP" ] && exit 0

echo " ${MSG} "
