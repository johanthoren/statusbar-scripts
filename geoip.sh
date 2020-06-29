#!/usr/bin/env bash

# Gets your public ip address checks which country you are in and
# displays that information in the statusbar
#
# https://www.maketecheasier.com/ip-address-geolocation-lookups-linux/

#command -p "geoiplookup" || exit

get_country() {
    grep "flag: " "$HOME/.local/share/emoji" |\
        grep "$(geoiplookup "$1" | sed 's/.*, //')" |\
        sed "s/flag: //;s/;.*//"
}

addr="$(curl ifconfig.me 2>/dev/null)" || exit 2
country="$(get_country "$addr")"
echo -e "\x01$country $addr\x01"
