#!/bin/bash

echo "Please enter database you want to select"
read db_name

if [ -d "$project_path/databases/$db_name" ]; 
then
	echo $project_path/databases/$db_name
	echo "database selected, what do you want to do ?"
	echo "Please enter a SQL command:"
	# Display menu 2
	select choise in "list tables" "create table" "insert into table" "select from table" "update table" "delete from table" "drop table"; do
    	case $choise in
    	"list tables")
	    echo "Listing tables..."
	    $project_path/scripts/list_tables.sh $db_name
	    ;;
	"create table")
	    echo "Please enter table name"
	    read table_name
	    $project_path/scripts/create_table.sh $db_name $table_name
	    ;;
	  "insert into table")
	    echo "Please enter table name"
	    read table_name
	    $project_path/scripts/insert_into_table.sh $db_name $table_name
	    ;;
	  "select from table")
	    echo "Please enter table name"
	    read table_name
	    $project_path/scripts/select_from_table.sh $db_name $table_name
	    ;;
	  "update table")
	    echo "Please enter table name"
	    read table_name
	    $project_path/scripts/update_table.sh $db_name $table_name
	    ;;
	  "delete from table")
	    echo "Please enter table name"
	    read table_name
	    $project_path/scripts/delete_from_table.sh $db_name $table_name
	    ;;
	  "drop table")
	    echo "Please enter table name"
	    read table_name
	    $project_path/scripts/drop_table.sh $db_name $table_name
	    ;;
	  *)
	    echo "Invalid command"
	    ;;
	esac
done
else
	echo Database $db_name not found
fi
