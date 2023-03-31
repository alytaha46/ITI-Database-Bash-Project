#!/bin/bash

db_name=$1

#project_path="/home/mina/Desktop/ITI-Database-Bash-Project"

if [ $project_path ]; then
    if [ `ls -A "$project_path/databases/$db_name"` ]; then
        typeset -i counter=1
        for table in $(ls "$project_path/databases/$db_name"); do
            echo "$counter) $table"
            counter=$(($counter + 1))
        done
    else
        echo no tables found
    fi
fi
