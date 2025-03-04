#!/bin/bash

<< comment
This is just for learn conditionals.. 
Like if, else, elif keywords...
comment

read -p "Enter your name: " name
read -p "Enter your age: " age

if [[ $age -ge 18 ]];
then
	echo "$name You are eligible for voting, because your age is $age..."
else
	echo "$name You are not eligible for voting, because your age is $age..."
fi
