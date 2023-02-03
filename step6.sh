#!/bin/bash

path=""
filename="Makefile"
tmp=""

if [[ "$1" != "config_file" ]]; then
    exit 0
fi

mktouch() {
    mkdir -p "$(dirname "$1")" && touch "$1";
}

while read -r line || [ -n "$line" ]; do 
    if [[ $line == "PROJECT_DIR" ]]; then
        read -r line
        path=$line
    fi
done < "$1"

echo -e "##\n## EPITECH PROJECT, 2023\n## Makefile\n## File description:\n## Makefile with makefile constructor\n##" >> $path"/Makefile"

current_key=""
declare -A array
array[0]="EXEC_NAME"
array[1]="CC"
array[2]="CPPFLAGS"
array[3]="LDFLAGS"
array[4]="CFLAGS"
array[5]="CLEAN"
array[6]="FCLEAN"
array[7]="RE"
array[8]="CFLAGS"
array[9]=*_DIR
array[10]="ALL"

current_key=""

while read -r line || [ -n "$line" ]; do 
    for val in "${array[@]}"; do
        if [[ "$line" == $val ]]; then
            if [[ $current_key != $line ]] && [[ $current_key != *_DIR ]]; then
                echo -e "" >> $path"/Makefile"
            fi
            current_key=$line
        fi
    done
    if [[ $current_key == "EXEC_NAME" ]] && [[ $line != "EXEC_NAME" ]]; then
        echo -e "EXEC_NAME =   "$line >> $path"/Makefile"
    elif [[ $current_key == *_DIR ]] && [[ $line == *_DIR ]] && [[ $line != "PROJECT_DIR" ]]; then
        echo -n $line"   =" >> $path"/Makefile"
    elif [[ $current_key == *_DIR ]] && [[ $line != *_DIR ]] && [[ $current_key != "PROJECT_DIR" ]]; then
        echo -e "\t" $line"\t\\" >> $path"/Makefile"
        mktouch $path$line
        tmp=${line%%.c}
        echo -e "/*\n** EPITECH PROJECT, 2023\n** "${tmp##*/}"\n** File description:\n** "${tmp##*/}" file\n*/\n" >> $path$line
    elif [[ $current_key == "CC" ]] && [[ $line != "CC" ]]; then
        echo -e "\n""$""(NAME):\n\t"$line >> $path"/Makefile"
    elif [[ $current_key == "CPPFLAGS" ]] && [[ $line != "CPPFLAGS" ]]; then
        echo -e "CPPFLAGS    =   "$line >> $path"/Makefile"
    elif [[ $current_key == "LDFLAGS" ]] && [[ $line != "LDFLAGS" ]]; then
        echo -e "LDFLAGS    =   "$line >> $path"/Makefile"
    elif [[ $current_key == "CFLAGS" ]] && [[ $line != "CFLAGS" ]]; then
        echo -e "CFLAGS    =   "$line"\n" >> $path"/Makefile"
    elif [[ $current_key == "ALL" ]] && [[ $line != "ALL" ]]; then
        echo -e $line >> $path"/Makefile"
    elif [[ $current_key == "CLEAN" ]] && [[ $line == "CLEAN" ]]; then
        echo -n "clean: " >> $path"/Makefile"
    elif [[ $current_key == "CLEAN" ]] && [[ $line != "CLEAN" ]]; then
        echo -e "\t$line" >> $path"/Makefile"
    elif [[ $current_key == "CLEAN" ]] && [[ $line == "CLEAN" ]]; then
        echo -n "clean: " >> $path"/Makefile"
    elif [[ $current_key == "CLEAN" ]] && [[ $line != "CLEAN" ]]; then
        echo -e "\t$line" >> $path"/Makefile"
    elif [[ $current_key == "FCLEAN" ]] && [[ $line == "FCLEAN" ]]; then
        echo -n "fclean: " >> $path"/Makefile"
    elif [[ $current_key == "FCLEAN" ]] && [[ $line != "FCLEAN" ]]; then
        echo -e "\t$line" >> $path"/Makefile"
    elif [[ $current_key == "RE" ]] && [[ $line == "RE" ]]; then
        echo -n "re: " >> $path"/Makefile"
    elif [[ $current_key == "RE" ]] && [[ $line != "RE" ]]; then
        echo -e "\t$line" >> $path"/Makefile"
    fi
done < "$1"
