curl -s \
  --form-string "token=APP_TOKEN" \
  --form-string "user=USER_KEY" \
  --form-string "message=$1" \
  https://api.pushover.net/1/messages.json
echo
