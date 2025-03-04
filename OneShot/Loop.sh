#!/bin/bash

<< comment
This is the script to learn loop...
comment

read -p "Enter the folder name: " foldername
read -p "How much folder you want to create: " range
for (( i=1 ; i<=$range ; i++ ))
do
	mkdir "$foldername$i"
	echo "$foldername$i created..."
done

for ((i=1 ; i<=$range ; i++))
do
	rmdir "$foldername$i"
	echo "$foldername$i deleted..."
done

num=0
while [[ $num -le 5 ]]
do
	echo "Line $num"
	num=$((num+1))
done

echo "This is to check even number..."

read -p "Enter the starting range: " frange
read -p "Enter the ending range: " lrange

curr=$frange

while [[ $curr -le $lrange ]]
do
	if [[ $(($curr%2)) -eq 0 ]]
	then
		echo "$curr is a even number"
	fi
	curr=$((curr+1))
done
