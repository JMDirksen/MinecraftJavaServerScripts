#!/bin/bash
cd "$(dirname "$0")"

[ $# -eq 0 ] && tail -F -n1 logs/latest.log | xargs -n1 -d '\n' ./logmon.sh
[ "$1" == "output" ] && [ -f logmon.output ] && cat logmon.output && rm logmon.output
[[ "$1" =~ "[Server thread/WARN]" ]] && echo $1 >> logmon.output
