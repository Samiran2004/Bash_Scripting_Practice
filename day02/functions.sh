#!bin/bash

function main() {
    read -p "Enter your name: " name
    if [[ $name == "Samiran" ]]
    then
        echo "Hello $name"
    else
        echo "Not Valid User!"
    fi
}

main