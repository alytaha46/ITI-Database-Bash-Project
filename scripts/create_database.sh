#!/bin/bash

# enable regex in bash
shopt -s extglob

# read database name from user
echo "choose database name"
read database_names
for database_names in $database_names; do
    # check the input match correct naming constrains
    if [[ $database_name && $database_name =~ ^[a-zA-Z0-9_]*$ ]]; then
        if [ -d ./databases/$database_name ]; then
            echo "database already exists choose a different database name"
        else
            mkdir ./databases/$database_name
            echo database $database_name created successfully
            break
        fi
    else
        echo "empty or invalid database name"
    fi
done
