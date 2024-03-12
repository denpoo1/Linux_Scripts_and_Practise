#!/bin/bash

old_text="$1"
new_text="$2"
work_directory="$3"


if [[ "$#" -ne 3 ]]; then
	echo "3 arguments required(old_text new_text work_directory)"
	exit 1
fi

if [[ ! -e "$work_directory" ]]; then
	echo "$work_directory -> directory don't exist"
	exit 1
fi

if [[ ! -d "$work_directory" ]]; then
	echo "$work_directory -> this is not a directory"
	exit 1
fi

if [[ ! -r "$work_directory" ]]; then
	echo "$work_directory -> read permission denied"
	exit 1
fi


for i in $(find "$work_directory" -type f); do
	if [[ -f "$i" ]]; then
	sed -i "s/$old_text/$new_text/g" "$i"
    fi
done

