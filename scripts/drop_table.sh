#!/bin/bash

db_name=$1

table_name=$2

#project_path="/home/mina/Desktop/ITI-Database-Bash-Project"


if [ -f "./databases/$db_name/$table_name" ]; then
rm -r "./databases/$db_name/$table_name"
echo table $table_name dropped successfully
else
echo table $table_name not found
fi

