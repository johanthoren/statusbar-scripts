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
    country="$(mullvad relay get | awk '{ print toupper ($NF) }')"

    case "$vpn_status" in
        Connected)
            MSG=" ${country}"
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
