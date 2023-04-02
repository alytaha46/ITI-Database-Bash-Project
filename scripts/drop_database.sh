#!/bin/bash

echo "Please enter database you want to delete"
read db_name

if [ -d "$project_path/databases/$db_name" ]; 
then
	rm -r "$project_path/databases/$db_name"
	echo Database $db_name dropped successfully
else
	echo Database $db_name not found
fi

