#!/bin/sh
MSG=""
PERC="$(acpi -b | cut -d ' ' -f 4 | uniq)"
PERC="${PERC%*,}"
PERC="${PERC%\%}"
STATUS="$(acpi -a | cut -d ' ' -f 3)"

if [ "$STATUS" = "on-line" ]; then
    # Only show the status if there is something interesting to show:
    [ "$PERC" -eq 100 ] && exit 0
    MSG="🔌 ${PERC}"
else
    MSG="🔋 ${PERC}"
    [ "$PERC" -le 20 ] && MSG="🔋 ${PERC}"
    [ "$PERC" -le 10 ] && MSG="🔋 ${PERC}"
fi

[ -z "$MSG" ] && exit 1
echo " ${MSG}% "
