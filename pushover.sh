#!/bin/bash
cd "$(dirname "$0")"

echo "$1" >> pushover.log
curl -s \
  --form-string "token=APP_TOKEN" \
  --form-string "user=USER_KEY" \
  --form-string "message=$1" \
  https://api.pushover.net/1/messages.json \
  >> pushover.log
echo >> pushover.log
