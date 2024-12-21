#!/bin/bash

FILEPATH="./demoFile.sh"

if [[ -f $FILEPATH ]]
then
	echo "File exist"
else
	echo "File not exist"
	touch $FILEPATH
fi
