#!/usr/bin/env bash
UNREAD="$(mu find flag:unread AND NOT flag:trashed AND NOT maildir:/Junk 2>/dev/null | wc -l)"

[ "$UNREAD" -eq 0 ] || echo " 📧 "
