#!/bin/bash

# Write a script that takes two arguments. If both are readable files then
# we compare their content. If their content in every respect
# (number of characters, number of words, number of lines and their content) is identical,
#, we display `OK`, and if they differ, we display the first line,
# which differ and we finish the script.

main_function() {
    checkCountArgument "$@"
    checkExistFiles "$@"
    checkReadiblePermission "$@"
    compareFilesContent "$@"
}

checkCountArgument() {
    if [[ ! "$#" -eq 2 ]]; then
        echo "Usage: $0 file1 file2"
        exit 1
    fi
}

checkReadiblePermission() {
    for file in "$@"; do
        if [[ ! -r "$file" ]]; then
            echo "File $file doesn't have read permission"
            exit 1
        fi
    done
}

checkExistFiles() {
    for file in "$@"; do
        if [[ ! -e "$file" ]]; then
            echo "File $file does not exist"
            exit 1
        fi
    done
}

compareFilesContent() {
    if diff -q "$1" "$2"; then
    	echo "Files $1 $2 are similar."
    else
    	echo "Files $1 $2 are different."
    fi
}

main_function "$@"