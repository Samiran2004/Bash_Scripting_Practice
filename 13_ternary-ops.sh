#!/bin/bash

#condition1 && condition2 || condition 3
read -p "Enter your age: " age
[[ $age -ge 18]] && echo "Adult" || echo "Minor"
