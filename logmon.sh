#!/bin/bash
cd "$(dirname "$0")"

[ $# -eq 0 ] && tail -F -n1 logs/latest.log | xargs -n1 -d '\n' ./logmon.sh
[[ "$1" =~ "[Server thread/WARN]" ]] && [[ ! "$1" =~ "]: Fetching" ]] && ./pushover.sh "$1"
