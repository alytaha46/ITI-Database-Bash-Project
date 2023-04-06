#!/bin/bash

db_name=$1

table_name=$2
if [ -f ./databases/$db_name/$table_name ]; then
file_path=./databases/$db_name/$table_name
 select option in "delete all table data" "delete by PK" "back"; do
                case $option in
                "delete all table data")
                	sed -i '4,$d' $file_path
                        ;;
                "delete by PK")
                	echo "please enter PK that you want to delete"
                	read pk
                	result=$(awk -v id="$pk" -F: '$1 == id { found=1; exit } END { if(found) print "yes"; else print "no" }' $file_path)
			if [[ $result == "yes" ]];then 
                        	awk -v id="$pk" -F: '$1 != id' $file_path > tmp.txt && mv tmp.txt $file_path
                        	echo row with PK = $pk deleted succesfly  
                        else echo pk not found
                        fi
                        ;;
                "back")
			exit
                        ;;

                esac

done

else
echo "table not found please enter different table name"
fi



