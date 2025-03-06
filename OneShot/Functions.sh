#!/bin/bash

#Check the number is even or not...
#This is function defination...
function isEven() {
	if [[ $(($1%2)) -eq 0 ]]
	then
		echo "$1 is an even number"
	else
		echo "$1 is not an even number..."
	fi
}

read -p "Enter a number to check the number is even or not: " num

#This is function call...
isEven $num
