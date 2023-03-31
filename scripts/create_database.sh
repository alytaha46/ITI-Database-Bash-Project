#!/bin/bash

# enable regex in bash
shopt -s extglob

# read database name from user
echo "choose database name"
while read db_name; do
    case $db_name in
    [a-zA-z]*)
        if [ -d $project_path/databases/$db_name ]; then
            echo "database already exists choose a different database name"
        else
            mkdir $project_path/databases/$db_name
            echo database $db_name created successfully
            break
        fi
        ;;
    *)
        echo "empty or invalid database name"
        ;;
    esac
done
