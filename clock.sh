#!/bin/sh
TIME="$(date +'%a %Y-%m-%d %H:%M')"
echo -e "\x01${TIME}" # No \x01 at the end since this should be the last script.
