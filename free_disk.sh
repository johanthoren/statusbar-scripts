#!/usr/bin/env bash
MSG=""
get_free() {
    df_out="$(df -h | grep "$1"\$)"
    free="$(awk '{print $4}' <<< "$df_out")"
    perc="$(awk '{print $5}' <<< "$df_out")"
    perc="${perc%\%}"
    [ "$perc" -le 79 ] && return 1

    echo "${1} $free"
}

ROOT_STATUS="$(get_free "/")"
HOME_STATUS="$(get_free "/home")"

# Only show information if there is something interesting to show.
ROOT_FREE=""
HOME_FREE=""
[ "$ROOT_STATUS" -eq 1 ] || ROOT_FREE="$ROOT_STATUS"
[ "$HOME_STATUS" -eq 1 ] || HOME_FREE="$HOME_STATUS"

MSG="${ROOT_FREE}${HOME_FREE}"

[ -z "$MSG" ] && exit 0
echo -e " 💽 ${MSG} "
