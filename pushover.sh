#!/bin/bash
cd "$(dirname "$0")"

[ ! -f pushover.conf ] && { echo Missing pushover.conf; exit 1; }
. pushover.conf

echo "$1" >> pushover.log
curl -s \
  --form-string "user=$user" \
  --form-string "token=$token" \
  --form-string "message=$1" \
  https://api.pushover.net/1/messages.json \
  >> pushover.log
echo >> pushover.log
