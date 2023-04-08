#!/bin/bash

# declare database path variable
database_path="./databases/$1"
if [[ $(ls "$database_path") ]]; then
    typeset -i counter=1
    echo "Listing tables..."
    for table in $(ls "$database_path"); do
        echo "$counter) $table"
        counter=$(($counter + 1))
    done
else
    echo no tables found
fi
