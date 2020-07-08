#!/usr/bin/env bash
MSG=""
ACPI="$(acpi -ab | grep -v 'Battery.*Unknown')"
PERC=""
PERCS="$(awk '/[0-9]{1,3}%/ { print $4 }' <<< "$ACPI")"
NUMS=($(tr -d [:punct:] <<< "$PERCS"))
COUNT=${#NUMS[@]}
if [ "$COUNT" -eq 1 ]; then
	PERC="$NUMS"
elif [ "$COUNT" -ge 2 ]; then
	SUM=$(IFS=+; echo "$((${NUMS[*]}))")
	PERC=$(( SUM / COUNT ))
fi

STATUS="$(awk '/Adapter/ { print $3 }' <<< "$ACPI")"

if [ "$STATUS" = "on-line" ]; then
    # Only show the status if there is something interesting to show:
    [ "$PERC" -eq 100 ] && exit 0
    [ -z "$PERC" ] && exit 1
    MSG="🔌 ${PERC}"
else
    MSG="🔋 ${PERC}"
fi

[ -z "$MSG" ] && exit 1
echo " ${MSG}% "
