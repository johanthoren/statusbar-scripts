#!/usr/bin/env bash
UNREAD="$(mu find flag:unread AND NOT flag:trashed AND NOT maildir:/Junk 2>/dev/null | wc -l)"

if [ "$UNREAD" -eq 0 ]; then
    exit 0
fi

MSG="✉ $UNREAD"

echo " $MSG "
