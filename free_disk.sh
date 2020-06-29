#!/usr/bin/env bash
MSG=""
get_free() {
    df_out="$(df -h | grep "$1"\$)"
    free="$(awk '{print $4}' <<< "$df_out")"
    perc="$(awk '{print $5}' <<< "$df_out")"
    perc="${perc%\%}"
    col="\x01"
    [ "$perc" -ge 80 ] && col="\x03"
    [ "$perc" -ge 90 ] && col="\x04"

    echo "${col}${1} $free"
}

MSG="💽$(get_free /)$(get_free /home)"

[ -z "$MSG" ] && exit 1
echo -e "\x01${MSG}\x01"
