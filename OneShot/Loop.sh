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
