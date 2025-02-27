#!/bin/bash

read -p "Enter username: " username

echo "You entered $username"

sudo useradd -m $username

echo "New User Added"

sudo userdel $username

echo "User Removed"
