#!/usr/bin/env bash
if ! command -v bibcal &> /dev/null; then
    echo "command not found: bibcal"
    exit 127
fi

major="$(bibcal -t | grep 'Major' | cut -d ' ' -f4- | sed 's/^\s*//g')"
minor="$(bibcal -t | grep 'Minor' | cut -d ' ' -f4- | sed 's/^\s*//g')"

if [ ! "$major" = "false" ]; then
    echo " $major "
    exit 0
elif [ ! "$minor" = "false" ]; then
    echo " $minor "
    exit 0
else
    exit 1
fi
