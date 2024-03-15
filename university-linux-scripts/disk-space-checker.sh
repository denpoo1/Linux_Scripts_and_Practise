#!/bin/bash

threshold="$1"

disk_usage=$(df -h / | awk 'NR==2 {print $5}' | cut -d'%' -f1)

if [ "$disk_usage" -gt "$threshold" ]; then
    echo "Warning: Disk space usage has exceeded $threshold%."
    echo "Current usage: $disk_usage%."
else
    echo "Disk space usage is normal: $disk_usage%."
fi
