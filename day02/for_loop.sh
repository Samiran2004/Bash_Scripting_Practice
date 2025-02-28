#!bin/bash

# This is for loop

read -p "Enter the number of folders you want to create: " count

for (( i=1 ; i<=$count ; i++ ))
do
	mkdir "demo$i"
done
