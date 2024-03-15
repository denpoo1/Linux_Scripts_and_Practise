#!/bin/bash

# Task 1
# Write a script that takes three arguments. If the first two are names
# files to read, and the third is the name of the file to write (this is mandatory
# check) then we write all lines from the file named 3rd argument
# file 1, which are not in file 2. The lines are to be written backwards, and all
# the characters in the line are to be reversed also reversed. The script is 
# supposed to display the number of such lines.

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


#----------------Solution 2---------------------------------
# #!/bin/bash

# if [[ ! $# -eq 3 ]]; then
#     echo "Zla liczba argumentow"
#     exit 1
# fi

# if [[ -f $3 && -f $2 && -f $1 ]]; then
#     # Check if file is writable
#     if [[ -w $3 ]]; then
#         # Intensionally splitting by spaces
#         mapfile -t lines1 < <(tac "$1")
#         mapfile -t lines2 < <(tac "$2")
#         # lines1=($(cat $1 | tac)) # skipcq: SH-2086
#         # lines2=($(cat $2 | tac)) # skipcq: SH-2086
#         for ((i = 0; i < ${#lines1[@]}; i++)); do
#             if [[ "${lines1[i]}" != "${lines2[i]}" ]]; then
#                 echo "${lines1[i]}" | rev >>"$3"
#             fi
#         done
#     else
#         echo "Plik $3 nie jest zapisywalny"
#         exit 2
#     fi
# else
#     echo "Files do not exist"
#     exit 3
# fi
