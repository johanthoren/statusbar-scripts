#!/bin/sh
MSG=""
PERC="$(acpi -b | cut -d ' ' -f 4 | uniq)"
PERC="${PERC%*,}"
PERC="${PERC%\%}"
STATUS="$(acpi -a | cut -d ' ' -f 3)"

if [ "$STATUS" = "on-line" ]; then
    # Only show the status if there is something interesting to show:
    [ "$PERC" -eq 100 ] && exit 0
    MSG="\x01🔌 ${PERC}"
else
    MSG="\x01🔋 ${PERC}"
    [ "$PERC" -le 20 ] && MSG="\x03🔋 ${PERC}"
    [ "$PERC" -le 10 ] && MSG="\x04🔋 ${PERC}"
fi

[ -z "$MSG" ] && exit 1
echo -e "${MSG}%\x01"
