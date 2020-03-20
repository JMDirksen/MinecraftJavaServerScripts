#!/bin/bash
cd "$(dirname "$0")"

# Check servername parameter
[ -z $1 ] && echo Missing parameter 'servername' && exit 2
servername=${1%/}

# Check optional memory parameter
[ -z $2 ] && memory=1G || memory=$2

pushd $servername > /dev/null
screen -dmS $servername java -Xmx$memory -Xms$memory -jar server.jar nogui
popd > /dev/null
