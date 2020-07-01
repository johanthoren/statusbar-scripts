#!/usr/bin/env bash
MSG=""

OUTPUT="$(pactl list sinks | grep -m1 combined -A7)"

MUTE_LINES="$(tail -n2 <<< "$OUTPUT")"
MUTE_LINE="$(head -n1 <<< "$MUTE_LINES")"

DUAL_LINE="$(tail -n1 <<< "$OUTPUT")"
DUAL_GREPPED="$(grep -o -P '(?<!\d)\d{1,3}(%)' <<< "$DUAL_LINE")"
DUAL="$(uniq <<< "$DUAL_GREPPED")"

LINES="$(wc -l <<< "${DUAL}")"
MUTE="$(cut -d' ' -f 2 <<< "$MUTE_LINE")"

if [ "$LINES" -eq 1 ]; then
    VOL="${DUAL%%\%*}"
    MSG="🔈 ${VOL}%"
    ((VOL > 30 && VOL < 79)) && MSG="🔉 ${VOL}%"
    [ "$VOL" -ge 80 ]&& MSG="🔊 ${VOL}%"
fi

[ ! "$LINES" -eq 1 ] && MSG="N/A"
[ "$MUTE" = "yes" ] && MSG="🔇"

[ -n "$MSG" ] || exit 1

echo " $MSG "
