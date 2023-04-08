#!/bin/bash

database_name=$1
table_name=$2
database_path="./databases/$database_name"
table_path="$database_path/$table_name"

# replace function
# args (pk,column_name,new_value)
function replace() {
        # get line number that match the primary key
        line_number=$(awk -F: -v pk="$1" 'NR>3 {if ($1 == pk) print NR}' $table_path)
        # get column index that match the selected column name
        column_index=$(head -n 1 $table_path | awk -F: -v c_n="$2" '{ for(i=1; i<=NF; i++) if ($i==c_n) print i }')
        # save the current whole row
        old_row=$(sed -n "${line_number}p" $table_path)
        # convert the current row to an array
        declare -a arr=($(echo "$old_row" | tr ':' ' '))
        # modify the old value with the new one
        arr[$(($column_index - 1))]=$3
        # convert the array back to a regular table row after modification
        new_line=$(echo ${arr[*]} | tr ' ' ':')
        # update the old row with the new row
        sed -i "${line_number}c ${new_line}" $table_path
}

# check if table exists
if [[ -f $table_path ]]; then
        # update table main menu
        select option in "update table name" "update column name" "update record(s)" "back"; do
                case $option in
                "update table name")
                        # read the new table name
                        read -p "enter new table name : " new_table_name
                        # rename column file
                        mv $table_path $database_path/$new_table_name
                        # print successful message after modification
                        echo table name changed from $table_name to $new_table_name successfully
                        # update table name variable value (in case of reuse)
                        # needs review
                        table_name=$new_table_name
                        table_path="$database_path/$table_name"
                        break
                        ;;
                "update column name")
                        # read current column name to modify
                        read -p "enter column name : " old_column_name
                        # check if column exists
                        if [[ $(head -n 1 "$table_path" | grep -w "$old_column_name") ]]; then
                                # read the new column name
                                read -p "enter new column name : " new_column_name
                                # replace the old column name with the new one
                                sed -i "1s/$old_column_name/$new_column_name/" $table_path
                                # print successful message after modification
                                echo column name changed from $old_column_name to $new_column_name successfully
                        else
                                echo column not found
                        fi
                        break
                        ;;
                "update record(s)")
                        # read primary keys from user
                        read -p "type primary keys (space separated) : " pks
                        # loop primary keys
                        for pk in $pks; do
                                # check if row exists
                                if [[ $(tail -n +4 "$table_path" | cut -d: -f1 | grep -w "$pk") ]]; then
                                        # read column name to edit
                                        read -p "type column(s) name for pk=$pk (space separated) : " columns_names
                                        # loop columns for each primary key
                                        for column_name in $columns_names; do
                                                # check if column exists
                                                if [[ $(sed -n '1p' "$table_path" | grep -w "$column_name") ]]; then
                                                        # read new value to edit
                                                        read -p "enter the new value for pk=$pk,column=$column_name: " new_value
                                                        # pass data to main replacement function
                                                        replace $pk $column_name $new_value
                                                else
                                                        echo column $column_name not found
                                                fi
                                        done
                                else
                                        echo pk=$pk not found
                                fi
                        done
                        break
                        ;;
                "back")
                        exit
                        ;;
                esac
        done

else
        echo "table $table_name not found"
fi
