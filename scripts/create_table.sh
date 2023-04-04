#!/bin/bash

# enable regex in bash
shopt -s extglob

db_name=$1

table_name=$2

case $table_name in
    [a-zA-Z_]*)
    if [ -f "./databases/$db_name/$table_name" ]; 
    	then
        echo table $table_name is already exists
    else
    	touch "./databases/$db_name/$table_name"
    	echo table $table_name created successfully
    fi
    ;;

    *)
    echo "empty or invalid table name"
    ;;
esac
