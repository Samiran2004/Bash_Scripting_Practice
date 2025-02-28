#!/bin/bash

<< disclaimer
This is just for infotainment purpose
disclaimer

read -p "Enter the name: " name

if [[ $name == "samiran" ]]
then
	echo "Jetha is loyal..."
elif [[ $name == "Samiran" ]]
then
	echo "Elif block execute..."
else
	echo "Jetha is not loyal..."
fi
