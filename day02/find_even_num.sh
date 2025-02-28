#!bin/bash

<< comment
This is the script to check even numbers in a given range
comment

read -p "Enter the range to find envn numbers: " range

count=1

while [[ $count -le $range ]]
do
    if [[ $(($count % 2)) -eq 0 ]]
    then
        echo $count
    fi
    count=$((count+1))
done