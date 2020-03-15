#!/bin/bash
cd "$(dirname "$0")"

# Check servername parameter
[ -z $1 ] && echo Missing parameter 'servername' && exit 2
servername=${1%/}

# Init
timestamp=$(date +%y%m%d%H%M%S)
backup=backup-$servername-$timestamp
tty -s && output=1 || output=
[ -d $servername ] || mkdir $servername
[ -f $servername/version.txt ] || touch $servername/version.txt

# Get latest version
[ $output ] && echo Checking latest version...
page=$(wget -qO- https://www.minecraft.net/en-us/download/server/)
version=$(echo $page | sed -r 's/.*>minecraft_server\.(.*)\.jar<.*/\1/')
url=$(echo $page | sed -r 's/.*(https:\/\/launcher.mojang.com\/v1\/objects\/.*server\.jar).*/\1/')
file=server.$version.jar
[ $output ] && echo Latest version: $version

# Installed version
installed=$(cat $servername/version.txt)
[ $output ] && echo Installed version: $installed

# Check if already on newest version
if [ "$version" == "$installed" ]; then
  [ $output ] && echo Up-to-date
  exit
fi

# Stop server
[ $output ] && echo Stopping server...
screen -S $servername -p 0 -X stuff "stop^M"
[ $? -eq 0 ] && sleep 10s

# Backup files
[ $output ] && echo Creating backup...
mkdir $backup
cp -r $servername $backup/

# New vesion
if [ ! -f "$file" ]; then
  [ $output ] && echo Downloading new version...
  wget -qO $file $url
fi

# Copy server
[ $output ] && echo Copying...
cp $file $servername/server.jar

# Register version
echo $version > $servername/version.txt

# Start server
[ $output ] && echo Starting server...
./start.sh $servername
echo Updated $servername to version $version
