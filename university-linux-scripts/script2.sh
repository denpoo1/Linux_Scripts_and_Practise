#!/bin/bash

# Napisz skrypt, który pobierze dwa argumenty. Jeżeli oba są plikami do odczytu to 
# porównujemy ich zawartość. Jeżeli ich zawartość pod każdym względem 
# (liczba znaków, liczba słów, liczba linii i ich zawartość) jest identyczna, 
# to wyświetlamy `OK`, a jeżeli się czymś różnią to wyświetlamy pierwszą linię, 
# którą się różnią i kończymy skrypt. 

# Do porównywania zawartości plików nie używamy poleceń zewnętrznych typu `cmp` lub `diff`.

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