#!/usr/bin/env bash
if ! command -v bibcal &> /dev/null; then
    echo "command not found: bibcal"
    exit 127
fi

day=$(bibcal -t)

major_feast="$(awk '/Major/ {print $6}' <<< "$day")"
minor_feast="$(awk '/Minor/ {print $6}' <<< "$day")"
sabbath="$(awk '/Sabbath/ {print $4}' <<< "$day")"

if [ ! "$major_feast" = "false" ]; then
    echo " $major_feast "
    exit 0
elif [ ! "$minor_feast" = "false" ]; then
    echo " $minor_feast "
    exit 0
elif [ ! "$sabbath" = "false" ]; then
    echo " Sabbath "
    exit 0
else
    exit 1
fi
