#!/bin/bash

directory=$1

if [[ ! -e "$directory" ]]; then
	echo "$directory not exist"
elif [[ ! -d "$directory" ]]; then
	echo "$directory is not a directory"
else
	echo "max file size in directory $directory have information $(ls -lS | head -n 2 | tail -n 1)"
fi