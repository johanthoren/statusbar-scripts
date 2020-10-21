#!/usr/bin/env bash
MSG=""

if command -v mullvad &> /dev/null; then
    relay_info="$(mullvad relay get)"
    relay_info="${relay_info##*city\ }"
    country="$(awk '{ print toupper ($2) }' <<< $relay_info)"
    city_code="$(awk '{ print $1 }' <<< $relay_info)"
    city_code="$(sed 's/,//' <<< $city_code)"
    city_name="$(mullvad relay list | grep \(${city_code}\) | head -n1 | awk -F '(' '{ print $1 }' | awk -F , '{ print $1 }' | sed 's/^\s*//' | sed 's/\s*$//')"
    vpn_status="$(mullvad status | awk '{print $3}')"

    case "$vpn_status" in
        Connected)
            MSG=" ${city_name}, ${country}"
            ;;
        Connecting)
            MSG="🔓 ${vpn_status}"
            ;;
        Disconnected)
            MSG="🔓 ${vpn_status}"
            ;;
        *)
            MSG="🔓 Unknown"
    esac
elif [ "$(hostname)" = "t490" ]; then
    vpn_if="ppp0"
    inet="$(ip addr | grep 'inet\ ')"
    vpn="$(grep "$vpn_if" <<< "$inet")"
    vpn_ip_cut="${vpn#*inet\ }"
    vpn_ip="${vpn_ip_cut%% peer*}"
    [ -n "$vpn_ip" ] && MSG="🌐 ${vpn_ip}"
fi

[ -n "$MSG" ] || exit 1
echo " ${MSG} "
