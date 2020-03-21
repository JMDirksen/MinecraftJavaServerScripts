#!/bin/bash
cd "$(dirname "$0")"

screen -dmS ${PWD##*/} ./loop.sh
