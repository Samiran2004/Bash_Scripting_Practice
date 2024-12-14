#!/bin/bash

while read myVar
do
    echo $myVar
done < names.txt
