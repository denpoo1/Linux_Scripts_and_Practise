#!/bin/bash

# Task 1
# Write a script that takes three arguments. If the first two are names
# files to read, and the third is the name of the file to write (this is mandatory
# check) then we write all lines from the file named 3rd argument
# file 1, which are not in file 2. The lines are to be written backwards, and all
# the characters in the line are to be reversed also reversed. The script is 
# supposed to display the number of such lines.

# 1=/home/denpool/Linux-Course/file1
# 2=/home/denpool/Linux-Course/file2
# 3=/home/denpool/Linux-Course/file3

# task1.sh /home/denpool/Linux-Course/file1 /home/denpool/Linux-Course/file2 /home/denpool/Linux-Course/file3

main_function() {
    checkCountArgument "$@"
    checkExistFiles "$@"
    checkReadiblePermission "$@"
    checkWritePermission "$@"
    writeNonMatchingLinesToNewFile "$@"
}

checkReadiblePermission() {
    for file in "$1" "$2"; do
        if [[ ! -r "$file" ]]; then
            echo "File $file doesn't have read permission"
            exit 1
        fi
    done
}

checkWritePermission() {
    if [[ ! -w "$3" ]]; then
        echo "File $3 doesn't have write permission"
        exit 1
    fi
}

checkCountArgument() {
    if [[ ! "$#" -eq 3 ]]; then
        echo "Usage: $0 file1 file2 file3"
        exit 1
    fi
}

checkExistFiles() {
    for file in "$@"; do
        if [[ ! -e "$file" ]]; then
            echo "File $file does not exist"
            exit 1
        fi
    done
}

writeNonMatchingLinesToNewFile() {
    local line
    local reversed_line
    local count=0
    
    while IFS= read -r line; do
        reversed_line=$(echo "$line" | rev)
        if ! grep -qFi "$line" "$2"; then
            echo "$reversed_line" >> "$3"
            ((count++))
        fi
    done < "$1"
    
    echo "Number of lines written to $3: $count"
}

main_function "$@"
