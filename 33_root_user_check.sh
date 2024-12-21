#!/bin/bash

#Checking if the user is root or not

if [[ $UID -eq 0 ]]
then
	echo "User is root."
else
	echo "User is not root."
fi
