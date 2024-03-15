#!/bin/bash

: 'Подсчет слов в текстовом файле: Напишите скрипт, который принимает имя 
текстового файла в качестве аргумента и выводит количество слов в этом файле.'

path_to_file=$1

if [[ ! -e "$path_to_file" ]]; then
	echo "file $path_to_file not exist"
else
	count_words_in_file=$(wc -w $path_to_file | grep -oE '[0-9]')
	echo "file $path_to_file contained $count_words_in_file words"
fi
