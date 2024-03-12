#!/bin/bash

directory_path=$1
directory_path=../EnvFiles

: 'Автоматическое создание резервных копий.'


if [[ ! -d "$directory_path" ]]; then
	echo "$directory_path is not a directory"
	exit 1
elif [[ ! -e "$directory_path" ]]; then
	echo "$directory_path is not exist"
	exit 1
else
	directory_name=$(basename "$directory_path")
	tar -cvf "${directory_name}_backup-file.tar" "$directory_path"
	gsutil cp "${directory_name}_backup-file.tar"  gs://denis-linux-backup-bucket
	exit 0
fi