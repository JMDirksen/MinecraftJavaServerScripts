#!/bin/bash
cd "$(dirname "$0")"

# Init
servername=${PWD##*/}
tty -s && output=1 || output=
[ -f version ] || touch version

# Get latest version
[ $output ] && echo Checking latest version...
page=$(wget -qO- https://www.minecraft.net/en-us/download/server/)
version=$(echo $page | sed -r 's/.*>minecraft_server\.(.*)\.jar<.*/\1/')
url=$(echo $page | sed -r 's/.*(https:\/\/launcher.mojang.com\/v1\/objects\/.*server\.jar).*/\1/')
file=server.$version.jar
[ $output ] && echo Latest version: $version

# Installed version
installed=$(cat version)
[ $output ] && echo Installed version: $installed

# Check if already on newest version
if [ "$version" == "$installed" ]; then
  [ $output ] && echo Up-to-date
  exit
fi

# Stop server
[ $output ] && echo Stopping server...
screen -S $servername -p 0 -X stuff "stop^M"
[ $? -eq 0 ] && sleep 15s
screen -S $servername -p 0 -X quit

# Create backup
[ $output ] && echo Creating backup...
backupfile=backup-$servername-$(date +%y%m%d%H%M%S).tar.gz
tar -zcf ../$backupfile .

# New version
if [ ! -f "$file" ]; then
  [ $output ] && echo Downloading new version...
  wget -qO $file $url
fi

# Copy server
[ $output ] && echo Copying...
cp $file server.jar

# Register version
echo $version > version

# Start server
[ $output ] && echo Starting server...
./start.sh
echo Updated $servername to version $version
