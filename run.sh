#!/bin/bash

# define and export project working directory
#export project_path=`pwd`

# check databases directory
if [ ! -d "./databases" ]; then
    mkdir "databases"
fi

# Display Main menu
select choise in "create database" "list databases" "connect to database" "drop database" "exit"; do
    case $choise in
    "create database")
        ./scripts/create_database.sh
        ;;
    "list databases")
        ./scripts/list_databases.sh
        ;;
    "connect to database")
        ./scripts/connect_database.sh
        ;;
    "drop database")
        ./scripts/drop_database.sh
        ;;
    "exit")
        exit
        ;;
    esac
done
