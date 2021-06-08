#!/usr/bin/env bash
set -euo pipefail
MSG=""

[ -f "$HOME/.at_work" ] && MSG="💼 At work"
[ -f "$HOME/.at_home" ] && MSG="🏡 At home"

[ -n "$MSG" ] || exit 1
echo " ${MSG} "
