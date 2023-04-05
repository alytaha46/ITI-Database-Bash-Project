#!/bin/bash

database_name=$1
table_name=$2
#PS3="$database_name>$table_name>"

# how to select from the table
function selectOptions {
    echo "What do you want to select"
    select option in "all records" "seelct row where pk = ?" "back" "main menu"; do
        case $option in
        "all records")
            sed -n 1p ./databases/$database_name/$table_name
            tail -n +4 ./databases/$database_name/$table_name
            ;;
        "seelct row where pk = ?")
            #search line 3 for primary key and detect primary key column name
            pk_index=$(awk -F: 'NR=3 {for(i=1; i<=NF; i++) if ($i == "PK") print i}' ./databases/$database_name/$table_name)
            if [ $pk_index ]; then
                # read primary key from user to select corresponding row from table
                typeset -i pk
                read -p "enter the primary key : " pk
                # print the matching row
                awk -F: -v pk="$pk" -v pk_index="$pk_index" 'NR>3 {if ($$pk_index == $pk) print $0}' ./databases/$database_name/$table_name
            else
                echo "table doesn't have a primary key"
            fi
            ;;
        "back")
            ./scripts/connect_database.sh $database_name
            ;;
        "main menu")
            ./run.sh
            ;;
        esac
    done
}

# print table info
function showTableInfo {
    # number of columns
    num_of_columns=$(sed -n '1p' ./databases/$database_name/$table_name | awk -F: '{ print NF }')
    echo $num_of_columns columns
    # number of columns
    num_of_records=$(tail -n +4 ./databases/$database_name/$table_name | wc -l)
    echo $num_of_records records
}

# check if table exists
if [ -f ./databases/$1/$2 ]; then
    selectOptions
    #showTableInfo
else
    echo table $2 not found
fi
