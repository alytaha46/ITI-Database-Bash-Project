#!/bin/bash

function validate_table {
	if [[ $3 =~ ^([a-zA-Z_])[a-zA-Z0-9_]*$ ]]; then
		$1 $2 $3
	else
		echo "empty or invalid table name"
	fi
}
ext=0
display_menu_2() {
	echo "$db_name database selected, what do you want to do ?"
	# Display menu 2
	select choise in "list tables" "create table" "insert into table" "select from table" "update table" "delete from table" "drop table" "back"; do
		case $choise in
		"list tables")
			./scripts/list_tables.sh $db_name
			break
			;;
		"create table")
			echo "Please enter table name"
			read table_name
			validate_table ./scripts/create_table.sh $db_name $table_name
			break
			;;
		"insert into table")
			echo "Please enter table name"
			read table_name
			validate_table ./scripts/insert_into_table.sh $db_name $table_name
			break
			;;
		"select from table")
			echo "Please enter table name"
			read table_name
			validate_table ./scripts/select_from_table.sh $db_name $table_name
			break
			;;
		"update table")
			echo "Please enter table name"
			read table_name
			validate_table ./scripts/update_table.sh $db_name $table_name
			break
			;;
		"delete from table")
			echo "Please enter table name"
			read table_name
			validate_table ./scripts/delete_from_table.sh $db_name $table_name
			break
			;;
		"drop table")
			echo "Please enter tables names"
			read table_names
			for table_name in $table_names; do
				validate_table ./scripts/drop_table.sh $db_name $table_name
			done
			break
			;;
		"back")
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

echo "Please enter database you want to select"
read db_name

if [ -d "./databases/$db_name" ]; then
	while true; do
		display_menu_2
		if [ $ext -eq 1 ]; then
			break
		fi
	done
else
	echo Database $db_name not found
fi
