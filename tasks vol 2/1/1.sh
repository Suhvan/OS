#!/usr/bin/env bash

if [[ $# -ne 2 ]]
then
    echo "Help: 1.sh file_1 file_2"
    exit 65
fi


if [[ ! -r "$1" || ! -r "$2" ]]
then
    echo "can't read unreadable file"
    exit 66
fi

declare -A dic

{
    while read hash size
    do
        while read filename && [[ -n "$filename" ]]
        do
            dic[$filename]="$hash:$size"
        done
    done
} < $1

{
    while read hash size filename
    do
        if [[ -n $hash && -n $size && -n $filename ]]
        then
            if [[ -n ${dic[$filename]} && ${dic[$filename]} != "$hash:$size" ]]
            then
                echo -e "filename: $filename"
                echo -e "    expected: $hash:$size"
                echo -e "    original: ${dic["$filename"]}"
            fi
        fi
    done
} < $2