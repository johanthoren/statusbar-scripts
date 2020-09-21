#!/usr/bin/env bash
INET="$(ip addr | grep 'inet\ ')"
ENP="$(grep enp <<< "$INET")"
ETH="$(grep eth <<< "$INET")"

ENP_IP_CUT="${ENP#*inet\ }"
ETH_IP_CUT="${ETH#*inet\ }"
ENP_IP="${ENP_IP_CUT%%\/*}"
ETH_IP="${ETH_IP_CUT%%\/*}"

MSG="❎"
#[ -n "$ENP_IP" ] && MSG="\x01🖧\x01"

# Only show the status if there is something interesting to show.
if [ -n "$ENP_IP" ] || [ -n "$ETH_IP" ]; then
    exit 0
fi

echo -e " $MSG "
