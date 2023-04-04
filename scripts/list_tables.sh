#!/bin/bash

db_name=$1
echo `ls -A "./databases/$db_name"`
#project_path="/home/mina/Desktop/ITI-Database-Bash-Project"


if [[ `ls -A "./databases/$db_name"` ]]; then
typeset -i counter=1
for table in $(ls "./databases/$db_name"); do
    echo "$counter) $table"
    counter=$(($counter + 1))
done
else
echo no tables found
fi
