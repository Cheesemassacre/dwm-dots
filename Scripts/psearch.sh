#!/bin/bash
process_name="$1"
pids=$(pgrep -f "$process_name")
if [ -z "$pids" ]; then
    echo "No processes found for '$process_name'."
    exit 1
fi
total_rss=$(ps -o rss= -p $pids | awk '{sum+=$1} END {print sum}')
echo "Total RSS for '$process_name': $((total_rss / 1024)) MB"
