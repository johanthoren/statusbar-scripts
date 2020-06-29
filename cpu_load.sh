#!/usr/bin/env bash
MSG=""
LOAD="$(uptime | awk -F'[a-z]:' '{ print $2}' | cut -d' ' -f 2 | cut -d',' -f 1)"
CORES=$(("$(lscpu -p=CORE | tail -n1)" + 1))
RELATIVE="$(bc <<< "scale=2; ${LOAD}/${CORES}")"
[[ "$RELATIVE" =~ ^\..* ]] && RELATIVE="0${RELATIVE}"

case "$RELATIVE" in
    [0][.][0-6]*)
        # If there is no real load to show, then don't.
        exit 0
        ;;
    [0][.][7-9]*)
        MSG="\x01🚚 ${RELATIVE}"
        ;;
    [1]*)
        MSG="\x03🚚 ${RELATIVE}"
        ;;
    [2-9]*)
        MSG="\x04🚚 ${RELATIVE}"
esac

[ -z "$MSG" ] && exit 1
echo -e "${MSG}\x01"
