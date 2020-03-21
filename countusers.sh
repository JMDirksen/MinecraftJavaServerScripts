#!/bin/bash
cd "$(dirname "$0")"

echo $(date +%y%m%d) $(find world/stats/ -type f -mtime -7 | wc -l)/$(find world/stats/ -type f -mtime -30 | wc -l)/$(find world/stats/ -type f | wc -l) >> usercount
