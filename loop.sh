#!/bin/bash
cd "$(dirname "$0")"

while true
do
  java -Xms1G -Xmx1G -jar server.jar
  echo 'Press Ctrl-C to stop'
  sleep 30
done
