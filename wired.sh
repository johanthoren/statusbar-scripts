#!/usr/bin/env bash
INET="$(ip addr | grep 'inet\ ')"
ENP="$(grep enp <<< "$INET")"

ENP_IP_CUT="${ENP#*inet\ }"
ENP_IP="${ENP_IP_CUT%%\/*}"

MSG="\x03❎\x01"
#[ -n "$ENP_IP" ] && MSG="\x01🖧\x01"

# Only show the status if there is something interesting to show.
[ -n "$ENP_IP" ] && exit 0

echo -e "$MSG"

