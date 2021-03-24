#!/usr/bin/env bash
set -euo pipefail

MSG=""

IFS=$'\n'
response=($(curl -s https://am.i.mullvad.net/json | \
            jq '.["ip", "country", "mullvad_exit_ip"]'))

[ "${#response[@]}" -ne 3 ] && echo "🔓 Unknown" && exit 1

ip_str="${response[0]}"
country_str="${response[1]}"
mullvad_exit_ip="${response[2]}"

ip_tmp="${ip_str%\"}"
ip="${ip_tmp#\"}"

country_tmp="${country_str%\"}"
country="${country_tmp#\"}"

case "$mullvad_exit_ip" in
    true)
        MSG="🔒 ${ip}, ${country}"
        ;;
    false)
        MSG="🔓 ${ip}, ${country}"
        ;;
    *)
        MSG="🔓 Unknown"
esac

[ -n "$MSG" ] || exit 1
echo " ${MSG} "
