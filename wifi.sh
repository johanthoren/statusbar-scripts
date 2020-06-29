#!/usr/bin/env bash
INET="$(ip addr | grep 'inet\ ')"
WLP="$(grep wlp <<< "$INET")"

WLP_IP_CUT="${WLP#*inet\ }"
WLP_IP="${WLP_IP_CUT%%\/*}"

MSG="\x03📡"
[ -n "$WLP_IP" ] && MSG="\x01📶"

echo -e "${MSG}\x01"

