#!/usr/bin/env bash
OS=$(uname)

MSG=""

get_free() {
    df_out="$(df -h | grep "$1"\$)"
    free="$(awk '{print $4}' <<< "$df_out")"
    perc="$(awk '{print $5}' <<< "$df_out")"
    perc="${perc%\%}"
    [ "$perc" -le 94 ] && return 1

    echo "${1} $free "
}

if [ "$OS" = "Linux" ]; then
	ROOT_STATUS="$(get_free "/")"
	HOME_STATUS="$(get_free "/home")"

	# Only show information if there is something interesting to show.
	ROOT_FREE=""
	HOME_FREE=""
	if [ ! "$ROOT_STATUS" = 1 ]; then
    		ROOT_FREE="$ROOT_STATUS"
	fi
	if [ ! "$HOME_STATUS" = 1 ]; then
    		HOME_FREE="$HOME_STATUS"
	fi

	MSG="${ROOT_FREE}${HOME_FREE}"

elif [ "$OS" = "OpenBSD" ]; then
	ROOT_STATUS="$(get_free "/")"
	HOME_STATUS="$(get_free "/home")"
	TMP_STATUS="$(get_free "/tmp")"
	USR_STATUS="$(get_free "/usr")"
	X11R6_STATUS="$(get_free "/usr/X11R6")"
	LOCAL_STATUS="$(get_free "/usr/local")"
	OBJ_STATUS="$(get_free "/usr/obj")"
	SRC_STATUS="$(get_free "/usr/src")"
	VAR_STATUS="$(get_free "/var")"

	# Only show information if there is something interesting to show.
	ROOT_FREE=""
	HOME_FREE=""
	TMP_FREE=""
	USR_FREE=""
	X11R6_FREE=""
	LOCAL_FREE=""
	OBJ_FREE=""
	SRC_FREE=""
	VAR_FREE=""
	if [ ! "$ROOT_STATUS" = 1 ]; then
    		ROOT_FREE="$ROOT_STATUS"
	fi
	if [ ! "$HOME_STATUS" = 1 ]; then
    		HOME_FREE="$HOME_STATUS"
	fi
	if [ ! "$TMP_STATUS" = 1 ]; then
    		TMP_FREE="$TMP_STATUS"
	fi
	if [ ! "$USR_STATUS" = 1 ]; then
    		USR_FREE="$USR_STATUS"
	fi
	if [ ! "$X11R6_STATUS" = 1 ]; then
    		X11R6_FREE="$X11R6_STATUS"
	fi
	if [ ! "$LOCAL_STATUS" = 1 ]; then
    		LOCAL_FREE="$LOCAL_STATUS"
	fi
	if [ ! "$OBJ_STATUS" = 1 ]; then
    		OBJ_FREE="$OBJ_STATUS"
	fi
	if [ ! "$SRC_STATUS" = 1 ]; then
    		SRC_FREE="$SRC_STATUS"
	fi
	if [ ! "$VAR_STATUS" = 1 ]; then
    		VAR_FREE="$VAR_STATUS"
	fi

	MSG="${ROOT_FREE}${HOME_FREE}${TMP_FREE}${USR_FREE}${X11R6_FREE}${LOCAL_FREE}${OBJ_FREE}${SRC_FREE}${VAR_FREE}"
fi

[ -z "$MSG" ] && exit 0
echo -e " ð½ ${MSG} "
