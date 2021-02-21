#!/usr/bin/env bash
MSG=""
get_free() {
    df_out="$(df -h | grep "$1"\$)"
    free="$(awk '{print $4}' <<< "$df_out")"
    perc="$(awk '{print $5}' <<< "$df_out")"
    perc="${perc%\%}"
    [ "$perc" -le 89 ] && return 1

    echo "${1} $free"
}

ROOT_STATUS="$(get_free "/")"
HOME_STATUS="$(get_free "/home")"
DOCKER_STATUS="$(get_free "/var/lib/docker")"

# Only show information if there is something interesting to show.
ROOT_FREE=""
HOME_FREE=""
DOCKER_FREE=""
if [ ! "$ROOT_STATUS" = 1 ]; then
    ROOT_FREE="$ROOT_STATUS"
fi
if [ ! "$HOME_STATUS" = 1 ]; then
    HOME_FREE="$HOME_STATUS"
fi
if [ ! "$DOCKER_STATUS" = 1 ]; then
    DOCKER_FREE="$DOCKER_STATUS"
fi

MSG="${ROOT_FREE}${HOME_FREE}${DOCKER_FREE}"

[ -z "$MSG" ] && exit 0
echo -e " 💽 ${MSG} "
