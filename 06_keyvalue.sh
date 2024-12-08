#!/bin/bash

#How to store key value paires

declare -A myarray

myarray=([name]="Samiran" [age]=20 [city]="Purba Mednipur")
echo "Name is ${myarray[name]}"
echo "Age is ${myarray[age]}"
echo "City is ${myarray[city]}"
