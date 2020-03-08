#!/bin/bash
cd "$(dirname "$0")"

# Check servername parameter
[ -z $1 ] && echo Missing parameter 'servername' && exit 2
servername=${1%/}

pushd $servername > /dev/null
screen -dmS $servername java -Xmx2G -Xms2G -jar server.jar nogui
popd > /dev/null
