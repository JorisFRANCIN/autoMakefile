#!/bin/bash

current_key=""
filename=""

while read -r line || [ -n "$line" ]; do 
    if [ "$line" == "FILE_NAME" ]; then
        current_key=$line
    elif [ "$line" == "INC" ]; then
        current_key=$line
    elif [ "$line" == "FNC" ]; then
        current_key=$line
    fi
    if [ "$line" != "FILE_NAME" ] && [ "$current_key" == "FILE_NAME" ]; then
        touch $line
        filename=$line
        echo -e "/*\n** EPITECH PROJECT, 2023\n** "${filename%%.c}"\n** File description:\n** "${filename%%.c}" file\n*/\n" >> $filename
    elif [ "$line" != "INC" ] && [ "$current_key" == "INC" ]; then
        echo -e "$line" >> $filename
    elif [ "$line" == "FNC" ] && [ "$current_key" == "FNC" ]; then
        echo -e "" >> $filename
    fi
    if [ "$line" != "FNC" ] && [ "$current_key" == "FNC" ] && [ "${line: -1}" != "}" ] && [ "${line: -1}" != "{" ]; then
        echo -e "\t$line" >> $filename
    elif [ "$line" != "FNC" ] && [ "$current_key" == "FNC" ]; then
        echo -e "$line" >> $filename
    fi
done < "$1"