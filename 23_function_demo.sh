#!/bin/bash

#To make a function...
function welcomeNote {
	echo "<------------------>"
	echo "WELCOME"
	echo "<------------------>"
}

#Another type to make a function...
greet() {
	echo "Hello World!"
}

#To call a function...
welcomeNote
welcomeNote
greet
