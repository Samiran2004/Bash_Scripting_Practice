#!/bin/bash

#Getting values from file names.txt

FILE="/run/media/samiransamanta/B68F-66EA/Bash_Scripting_Practice/names.txt"

for name in $(cat $FILE)
do
    echo "Name is: $name"
done
