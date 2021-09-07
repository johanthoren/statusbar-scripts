#!/usr/bin/env bash
if ! command -v bibcal &> /dev/null; then
    echo "command not found: bibcal"
    exit 127
fi

day=$(bibcal -t)
major="$(grep 'Major' <<< "$day")"
major="$(grep 'Minor' <<< "$day")"

major_feast="$(cut -d ' ' -f4- <<< "$major" | sed 's/^\s*//g')"
minor_feast="$(cut -d ' ' -f4- <<< "$minor" | sed 's/^\s*//g')"

if [ ! "$major_feast" = "false" ]; then
    echo " $major_feast "
    exit 0
elif [ ! "$minor_feast" = "false" ]; then
    echo " $minor_feast "
    exit 0
else
    exit 1
fi
