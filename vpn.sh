#!/usr/bin/env bash
set -euo pipefail
# Make sure to have $WORK_IP and $WORK_NAME in your $HOME/.profile
# if you want to use the IP match exception. Else, remove this part.
source "$HOME/.profile"

MSG=""
SECONDARY=""

if ip a show dev tunsnx > /dev/null 2>&1; then
    SECONDARY=" + ${WORK_NAME}"
fi

IFS=$'\n'
response=($(curl -s https://am.i.mullvad.net/json | \
            jq '.["ip", "country", "mullvad_exit_ip"]'))

[ "${#response[@]}" -ne 3 ] && echo "🔓 Unknown${SECONDARY}" && exit 1

ip_str="${response[0]}"
country_str="${response[1]}"
mullvad_exit_ip="${response[2]}"

ip_tmp="${ip_str%\"}"
ip="${ip_tmp#\"}"

country_tmp="${country_str%\"}"
country="${country_tmp#\"}"

case "$mullvad_exit_ip" in
    true)
        MSG="🔒 ${country}${SECONDARY}"
        ;;
    false)
        MSG="🔓 ${ip}, ${country}${SECONDARY}"
        ;;
    *)
        MSG="🔓 Unknown${SECONDARY}"
esac

[ -n "$MSG" ] || exit 1
echo " ${MSG} "
