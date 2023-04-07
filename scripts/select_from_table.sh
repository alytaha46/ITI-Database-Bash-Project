#!/bin/bash

database_name=$1
table_name=$2
database_path="./databases/$database_name"
table_path="$database_path/$table_name"

# how to select from the table
function selectOptions {
    echo "What do you want to select"
    select option in "all records" "select row(s)" "back" "main menu"; do
        case $option in
        "all records")
            sed -n 1p $table_path
            tail -n +4 $table_path
            ;;
        "select row(s)")
            # read primary keys from user
            read -p "type primary keys (space separated) : " pks
            # read column name to view
            read -p "type column(s) name to view (space separated) : " columns_names
            # output
            declare -A result
            # loop primary keys
            for pk in $pks; do
                # check if row exists
                if [[ $(tail -n +4 "$table_path" | cut -d: -f1 | grep -w "$pk") ]]; then
                    if [[ $columns_names ]]; then
                        # loop columns for each primary key
                        declare -A columns_indeces
                        typeset -t counter=0
                        for column_name in $columns_names; do
                            # check if column exists
                            if [[ $(sed -n '1p' "$table_path" | grep -w "$column_name") ]]; then
                                columns_indeces[$counter]=$(head -n 1 $table_path | awk -F: -v c_n="$column_name" '{ for(i=1; i<=NF; i++) if ($i==c_n) print i }')
                                counter=$counter+1
                            fi
                        done
                        col_ind=$(echo ${columns_indeces[*]} | tr ' ' ',')
                        tail -n +4 "$table_path" | grep -w "$pk" | cut -d: -f"$col_ind"
                    else
                        tail -n +4 "$table_path" | grep -w "^$pk"
                    fi
                fi
            done
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

# check if table exists
if [ -f $table_path ]; then
    selectOptions
else
    echo table $2 not found
fi
