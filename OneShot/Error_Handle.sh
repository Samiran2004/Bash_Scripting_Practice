#!/bin/bash

function create_dir() {
	mkdir demo
}

if ! create_dir; then
	echo "The code is being exited as the dir already exist"
	exit 1
fi

echo "This should not work because the code is interrupted"
