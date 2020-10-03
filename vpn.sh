#!/usr/bin/env bash
HOSTNAME="$(hostname)"
MSG=""
if [ "$HOSTNAME" = "t490" ]; then
    vpn_if="ppp0"
    inet="$(ip addr | grep 'inet\ ')"
    vpn="$(grep "$vpn_if" <<< "$inet")"
    vpn_ip_cut="${vpn#*inet\ }"
    vpn_ip="${vpn_ip_cut%% peer*}"
    [ -n "$vpn_ip" ] && MSG="🌐 ${vpn_ip}"
elif [ "$HOSTNAME" = "t470s" ]; then
    vpn_status="$(mullvad status | awk '{print $3}')"
    relay_info="$(mullvad relay get)"
    country="$(awk '{ print toupper ($NF) }' <<< $relay_info)"
    city_code="$(awk '{ print $(NF - 1) }' <<< $relay_info)"
    city_code="$(sed 's/,//' <<< $city_code)"
    city_name="$(mullvad relay list | grep \(${city_code}\) | head -n1 | awk -F '(' '{ print $1 }' | awk -F , '{ print $1 }' | sed 's/^\s*//' | sed 's/\s*$//')"

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
fi

[ -n "$MSG" ] || exit 1
echo " ${MSG} "
