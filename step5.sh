#!/bin/bash

current_key=""
current_folder=""
path_key="/"

while read -r line || [ -n "$line" ]; do 
    if [[ "$line" == /* ]]; then
        current_key="FOLDER"
        current_folder=${line:1}
        mkdir $current_folder
    elif [[ "$line" == -* ]]; then
        current_key="FILE"
        mkdir $current_folder$path_key${line:1}
    fi
done < "$1"