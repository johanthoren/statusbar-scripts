#!/usr/bin/env bash
if ! command -v sunwait &> /dev/null; then
    echo "command not found: sunwait"
    exit 127
fi
day_of_week=$(date +%w)
day_or_night=$(sunwait poll "${LATITUDE}N ${LONGITUDE}E")

if [ "$day_of_week" -eq 5 ] && [ "$day_or_night" = "NIGHT" ]; then
    echo " Shabbat Shalom! "
    exit 0
elif [ "$day_of_week" -eq 6 ] && [ "$day_or_night" = "DAY" ]; then
    echo " Shabbat Shalom! "
    exit 0
else
    exit 1
fi
