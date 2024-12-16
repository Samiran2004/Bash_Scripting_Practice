#!/bin/bash

#SHOW RESULTS...
function print {
	echo "RESULT: $1"
}

#FUNCTION FOR ADD...
function add {
	num1=$1
	num1=$2
	sum=$((num1 + num2))
	print $sum
}

#FUNCTION FOR SUBTRACTION...
function sub {
	num1=$1
	num2=$2
	sub=$((num1 - num2))
	print $sub
}

#FUNCTION FOR DIVISION...
function div {
	num1=$1
	num2=$2
	div=$((num1 / num2))
	print $div
}

#FUNCTION FOR MULTIPLICATION...
function multi {
	num1=$1
	num2=$2
	mul=$((num1 * num2))
	print $mul
}

#READ THE VARIABLES FROM USER
read -p "ENTER 1ST NUMBER: " num1
read -p "ENTER 2ND NUMBER: " num2
#READ OPERATOR FROM USER
echo "<--------------OPTIONS-------------->"
echo "(a/A) for addition."
echo "(s/S) for subtraction."
echo "(m/M) for multiplication."
echo "(d/D) for division."

