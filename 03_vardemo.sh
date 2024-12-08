#!/bin/bash

#Script to show how to use variables

a=10
name="Samiran"
age=20

echo "My name is $name, My age is $age"

name="Guddu"

echo "My name is $name"

#Var to store the output of a command

HOSTNAME=$(hostname)
echo "Name of this machine is $HOSTNAME"
