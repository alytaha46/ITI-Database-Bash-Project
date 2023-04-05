#!/bin/bash

database_name=$1
table_name=$2

function updateOptions {
        select option in "update table name" "update column name" "update record" "back" "main menu"; do
                case $option in
                "update table name")
                        read -p "enter table name : " new_table_name
                        mv ./databases/$database_name/$table_name ./databases/$database_name/$new_table_name
                        echo table name changed from $table_name to $new_table_name successfully
                        table_name=$new_table_name
                        ;;
                "update column name")
                        read -p "enter column name you want to change: " old_column_name
                        read -p "enter new column name: " new_column_name
                        sed -i "1s/$old_column_name/$new_column_name/g" ./databases/$database_name/$table_name
                        echo column name changed from $old_column_name to $new_column_name successfully
                        ;;
                "update record")
                        pk_index=$(awk -F: 'NR=3 {for(i=1; i<=NF; i++) if ($i == "PK") print i}' ./databases/$database_name/$table_name)
                        if [ $pk_index ]; then
                                # read primary key from user to select corresponding row from table
                                typeset -i pk
                                read -p "enter the primary key : " pk
                                # print the matching row
                                echo The current Row :
                                old_row=$(awk -F: -v pk="$pk" -v pk_index="$pk_index" 'NR>3 {if ($$pk_index == $pk) print $0}' ./databases/$database_name/$table_name)
                                line_number=$(awk -F: -v pk="$pk" -v pk_index="$pk_index" 'NR>3 {if ($$pk_index == $pk) print NR}' ./databases/$database_name/$table_name)
                                #echo line number is $line_number
                                echo $old_row
                                echo "---------------------------------"
                                read -p "enter columns names to modify (space separated) : " columns
                                read -p "enter new values (space separated) : " values
                                typeset -i counter=0
                                for column_name in ${columns[*]}; do
                                        column_index=`head -n 1 ./databases/$database_name/$table_name | awk -F: -v c_n="$column_name" '{ for(i=1; i<=NF; i++) if ($i==c_n) print i }'`
                                        awk -v c_i="$column_index" -v l_n="$line_number" -v n_v="${values[$counter]}" 'BEGIN {FS=OFS=":"} NR==l_n { $c_i = n_v; print }' ./databases/$database_name/$table_name  > ./databases/$database_name/temp && mv ./databases/$database_name/temp ./databases/$database_name/$table_name
                                        counter=$counter+1
                                done
                                echo "the row has been modified successfully"
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

# check if table exists
if [ -f ./databases/$1/$2 ]; then
        updateOptions
        #showTableInfo
else
        echo table $2 not found
fi
