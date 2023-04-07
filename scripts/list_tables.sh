#!/bin/bash

if [[ $1 ]]; then
    # declare database path variable
    database_path="./databases/$1"
    if [[ $(ls "$database_path") ]]; then
        typeset -i counter=1
        for table in $(ls "$database_path"); do
            echo "$counter) $table"
            counter=$(($counter + 1))
        done
    else
        echo no tables found
    fi
else
    echo no database selected
fi
