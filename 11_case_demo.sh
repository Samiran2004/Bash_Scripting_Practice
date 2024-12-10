#!/bin/bash

echo "<----Provide an option---->"

echo "(a) for print date."
echo "(b) for list of scripts."
echo "(c) for current location."

read -p "Enter: " choice

case $choice in
	a)
		echo "Today's date is: $(date)"
		;;
	b)ls;;
	c)pwd;;
	*)echo "Not a valid option!!"
esac
