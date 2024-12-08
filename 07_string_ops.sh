#!/bin/bash

myVar="Hello World"

myVarLength=${#myVar}
echo "Length of the myVar is $myVarLength"

echo "Upper case is: ${myVar^^}"
echo "Lower case is: ${myVar,,}"

#To replace a string

newVar=${myVar/World/Samiran}
echo "New variable is: ${newVar}"

#To slice a string
sliceVar=${myVar:3:7}
echo "Slice variable is: ${sliceVar}"
