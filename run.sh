#!/bin/bash
ext=0
display_main_menu() {
    # Display Main menu
    select choise in "create database" "list databases" "connect to database" "drop database" "exit"; do
        case $choise in
        "create database")
            ./scripts/create_database.sh
            break
            ;;
        "list databases")
            ./scripts/list_databases.sh
            break
            ;;
        "connect to database")
            ./scripts/connect_database.sh
            break
            ;;
        "drop database")
            ./scripts/drop_database.sh
            break
            ;;
        "exit")
            exit
            ext=1
            ;;
        *)
			echo "Invalid command"
            break
			;;
        esac
    done
}
# create databases directory if doesn't exist
if [ ! -d "./databases" ]; then
    mkdir "databases"
fi

while true; do
    display_main_menu
    if [ $ext -eq 1 ]; then
        break
    fi
done
