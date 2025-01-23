#!/bin/bash

FU=$(df -H | egrep -v "Filesystem|tmpfs" | grep "nvme0n1p7" | awk '{print $5}' | tr
 -d %)

if [[ $FU -ge 2 ]]
then
    echo "Warning, disk space is low"
else
    echo "All Good"
fi