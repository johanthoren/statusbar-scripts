#!/usr/bin/env bash
if ! command -v bibcal &> /dev/null; then
    echo "command not found: bibcal"
    exit 127
fi

bibcal -s && echo " Shabbat Shalom! " && exit 0
exit 1
