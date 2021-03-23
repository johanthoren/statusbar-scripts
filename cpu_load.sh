#!/usr/bin/env bash
OS=$(uname)

MSG=""
LOAD="$(uptime | awk -F'[a-z]:' '{ print $2}' | cut -d' ' -f 2 | cut -d',' -f 1)"

if [ "$OS" = "Linux" ]; then
	CORES=$(("$(lscpu -p=CORE | tail -n1)" + 1))
elif [ "$OS" = "OpenBSD" ]; then
	CORES=$(sysctl -n hw.ncpu)
fi

RELATIVE="$(bc <<< "scale=2; ${LOAD}/${CORES}")"
[[ "$RELATIVE" =~ ^\..* ]] && RELATIVE="0${RELATIVE}"

case "$RELATIVE" in
    [0]*)
        # If there is no real load to show, then don't.
        exit 0
        ;;
    [1-9]*)
        MSG="🚚 ${RELATIVE}"
esac

[ -z "$MSG" ] && exit 1
echo " ${MSG} "
