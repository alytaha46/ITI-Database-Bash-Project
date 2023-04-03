#!/bin/bash

db_name=$1
table_name=$2
#PS3="$db_name>$table_name>"

# how to select from the table
function selectOptions {
    echo "What do you want to select"
    select option in "all records" "by record number" "by primary key"; do
        case $option in
        "all records")
            echo "all"
            ;;
        "by record number")
            typeset -i num
            read -p "enter record num : " num
            if [ $num -gt 0 ]; then
                sed -n $(($num+3))p ./databases/$db_name/$table_name
            else
                echo invalid record number
                break
            fi
            ;;
        "by primary key")
            echo primary
            ;;
        esac
    done
}

# print table info
function showTableInfo {
    # number of columns
    num_of_columns=$(sed -n '1p' ./databases/$db_name/$table_name | awk -F: '{ print NF }')
    echo $num_of_columns columns
    # number of columns
    num_of_records=$(tail -n +4 ./databases/$db_name/$table_name | wc -l)
    echo $num_of_records records
}

# check if table exists
if [ -f ./databases/$1/$2 ]; then
    selectOptions
    #showTableInfo
else
    echo table $2 not found
fi
