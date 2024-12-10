#!/bin/bash

read -p "Enter your marks: " marks

if [[ $marks -gt 40 ]]
then
	echo "You passed"
else
	echo "You failed"
fi

if [ $marks -ge 80 ]
then
	echo "You got First Division"
elif [ $marks -ge 60 ]
then
	echo "You got Second Division"
else
	echo "You're already fail!!!"
fi
