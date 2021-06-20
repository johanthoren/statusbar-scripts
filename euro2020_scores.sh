#!/usr/bin/env bash
set -euo pipefail

$HOME/bin/status/sabbath.sh &> /dev/null && exit 1

finished=0

data=$(curl -s -H 'Content-Type: application/json' \
    -H 'X-Auth-Token: 423bfd3ce27d4b789de6de3bbfacccf0' \
    https://api.football-data.org/v2/competitions/EC/matches\?status\=LIVE)

count=$(jq '.["count"]' <<< "$data")

if [ "$count" -eq 0 ]; then
    data=$(curl -s -H 'Content-Type: application/json' \
        -H 'X-Auth-Token: 423bfd3ce27d4b789de6de3bbfacccf0' \
        https://api.football-data.org/v2/competitions/EC/matches\?status\=FINISHED)
    finished=1
fi

matches=$(jq '.["matches"]' <<< "$data")
latest_match=$(jq '.[-1]' <<< "${matches}")
home_team=$(jq '.["homeTeam"]["name"]' <<< "$latest_match")
away_team=$(jq '.["awayTeam"]["name"]' <<< "$latest_match")
home_score=$(jq '.["score"]["fullTime"]["homeTeam"]' <<< "$latest_match")
away_score=$(jq '.["score"]["fullTime"]["awayTeam"]' <<< "$latest_match")

score=$(sed 's/\"//g' <<< "$home_team $home_score - $away_score $away_team")
[ "$finished" -eq 1 ] && res="Latest: ${score}" || res="Playing: ${score}"
echo " ${res} "
exit 0
