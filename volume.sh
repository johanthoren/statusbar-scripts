#!/usr/bin/env bash
OS=$(uname)

MSG=""

if [ "$OS" = "Linux" ]; then
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

elif [ "$OS" = "OpenBSD" ]; then
	VOL=$(sndioctl -n output.level)
	printf -v VOL %.0f $(bc<<<$VOL*100)
    	MSG="🔈 ${VOL}%"
    	((VOL > 30 && VOL < 79)) && MSG="🔉 ${VOL}%"
 	[ "$VOL" -ge 80 ]&& MSG="🔊 ${VOL}%"

	[ -z "$VOL" ] && MSG="N/A"
	[ $(sndioctl -n output.mute) -eq 1 ] && MSG="🔇"

fi

[ -n "$MSG" ] || exit 1

echo " $MSG "
