#!/bin/bash

echo "Please enter database you want to select"
read db_name

if [ -d "./databases/$db_name" ]; 
then
	echo "database selected, what do you want to do ?"
	# Display menu 2
	select choise in "list tables" "create table" "insert into table" "select from table" "update table" "delete from table" "drop table"; do
    	case $choise in
    	"list tables")
	    echo "Listing tables..."
	    ./scripts/list_tables.sh $db_name
	    ;;
	"create table")
	    echo "Please enter table name"
	    read table_name
	    ./scripts/create_table.sh $db_name $table_name
	    ;;
	  "insert into table")
	    echo "Please enter table name"
	    read table_name
	    ./scripts/insert_into_table.sh $db_name $table_name
	    ;;
	  "select from table")
	    echo "Please enter table name"
	    read table_name
	    ./scripts/select_from_table.sh $db_name $table_name
	    ;;
	  "update table")
	    echo "Please enter table name"
	    read table_name
	    ./scripts/update_table.sh $db_name $table_name
	    ;;
	  "delete from table")
	    echo "Please enter table name"
	    read table_name
	    ./scripts/delete_from_table.sh $db_name $table_name
	    ;;
	  "drop table")
	    echo "Please enter table name"
	    read table_name
	    ./scripts/drop_table.sh $db_name $table_name
	    ;;
	  *)
	    echo "Invalid command"
	    ;;
	esac
done
else
	echo Database $db_name not found
fi
