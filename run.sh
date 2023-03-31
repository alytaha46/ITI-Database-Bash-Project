#!/bin/bash

# define and export project working directory
export project_path=`pwd`

# check databases directory
if [ ! -d "$project_path/databases" ]; then
    mkdir "$project_path/databases"
fi

# Display Main menu
select choise in "create database" "list databases" "connect to database" "drop database"; do
    case $choise in
    "create database")
        $project_path/scripts/create_database.sh
        ;;
    "list databases")
        $project_path/scripts/list_databases.sh
        ;;
    "connect to database")
        $project_path/scripts/connect_database.sh
        ;;
    "drop database")
        $project_path/scripts/drop_database.sh
        ;;
    esac
done
