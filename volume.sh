#!/usr/bin/env bash
MSG=""
HP=""
AIRPODS="$(bluetoothctl info E4:90:FD:29:5A:DC | grep Connected | cut -d ' ' -f 2)"
[ "$AIRPODS" = "yes" ] && HP=" 🎧"

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
    MSG="\x01🔈 ${VOL}%${HP}"
    ((VOL > 30 && VOL < 79)) && MSG="\x01🔉 ${VOL}%${HP}"
    [ "$VOL" -ge 80 ]&& MSG="\x01🔊 ${VOL}%${HP}"
fi

[ ! "$LINES" -eq 1 ] && MSG="\x04N/A${HP}"
[ "$MUTE" = "yes" ] && MSG="\x04🔇${HP}"

[ -n "$MSG" ] || exit 1

echo -e "$MSG\x01"
