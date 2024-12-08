#!/bin/bash

#Array

myArray=(1 2 7.5  Hello "Hey Samiran")
echo "All the values in the array are ${myArray[*]}"
echo "Index 0: ${myArray[0]}"
echo "Index 1: ${myArray[1]}"
echo "Index 2: ${myArray[2]}"
echo "Index 3: ${myArray[3]}"

#How to find no of values in an array

echo "Number of values or Length of the array is: ${#myArray[*]}"

echo "Values from index 2-3: ${myArray[*]:2:2}"

#Updating the array with new values
myArray+=(New 30 40 )
echo "New Array: ${myArray[*]}"
