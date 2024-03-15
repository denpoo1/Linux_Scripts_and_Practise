#!/bin/bash

# Write a script that takes three arguments.

# If the first two are filenames to read and the third is the name
# of the file to be written, we write all of them to the file named after the 3rd argument
# lines from file 1 that are in file 2.

# The script should display the number of characters in each such line, and the number
# spaces on each line (we assume there are no two spaces next to each other)
# and the number of lines containing the letter `a` or `A`

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
    local lineCount=1
    local line
    local countLetterA_InAllLines=0
    
    while IFS= read -r line; do
        if ! grep -qFi "$line" "$2"; then
            echo "$line" >> "$3"
            echo "Line $lineCount in file $1 contained:"
            echo "Spaces: $(awk "NR==$lineCount {print gsub(/ /,\"\")}" "$1")"
            echo "All chars: $(awk "NR==$lineCount {print length}" "$1")"
            countLetterA_InAllLines=$((countLetterA_InAllLines + $(awk "NR==$lineCount {print gsub(/a/,\"\")}" "$1")))
        fi
        ((lineCount++))
    done < "$1"

    echo "All count letter A: $countLetterA_InAllLines"
}

    

main_function "$@"