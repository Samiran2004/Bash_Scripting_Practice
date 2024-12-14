#!/bin/bash

while IFS="," read  id name age
do
    echo "Id: $id"
    echo "Name: $name"
    echo "Age: $age"
done < test.csv

#Another process...

echo "Using Another Process"
cat test.csv | awk 'NR!=1 {print}' | while IFS="," read id name age
do
    echo "Id is: $id"
done
