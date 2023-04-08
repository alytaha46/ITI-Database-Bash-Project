#!/bin/bash

echo "Please enter databases you want to delete"
read db_names

for db_name in $db_names; do
	if [ -d "./databases/$db_name" ]; then
		rm -r "./databases/$db_name"
		echo Database $db_name dropped successfully
	else
		echo Database $db_name not found
	fi
done
