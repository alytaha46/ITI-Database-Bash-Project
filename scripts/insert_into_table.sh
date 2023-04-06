#!/bin/bash

insert_line()
{
num_lines=$(wc -l < "$file_path")
last_pk=0
if [ "$num_lines" -gt 3 ]; then
  last_line=$(tail -n 1 "$file_path")
  IFS=":" read -ra last <<< "$last_line"
  last_pk=$((last[0]))
fi


last_pk=$((last_pk+1))

declare -a added_line=()
added_line+=("$last_pk")

for ((i=1; i<${#col_names[@]}; i++)); do

echo "Enter "${col_names[i]}""
  while read elem1; do
  if [[ ${datatypes[i]} == "string" &&  ${constrains[i]} == "NULL" ]] ;then
	added_line+=("$elem1")
	break
elif [[ ${datatypes[i]} == "string" &&  ${constrains[i]} == "NOT_NULL" ]] ;then
	if [[ $elem1 =~ ^.+$ ]]; then
	added_line+=("$elem1")
	break
	else
	echo "empty or invalid input"
	fi
elif [[ ${datatypes[i]} == "int" &&  ${constrains[i]} == "NULL" ]] ;then
	if [[ $elem1 =~ ^[+-]?[0-9]*$ ]]; then
	added_line+=("$elem1")
	break
	else
	echo "empty or invalid input"
	fi
elif [[ ${datatypes[i]} == "int" &&  ${constrains[i]} == "NOT_NULL" ]] ;then
	if [[ $elem1 =~ ^[+-]?[0-9]+$ ]]; then
	added_line+=("$elem1")
	break
	else
	echo "empty or invalid input"
	fi
fi

done


done


line1=""
for element in "${added_line[@]}"; do
  line1+="$element:"
done
line1=${line1%?}
echo $line1 >> ./databases/$db_name/$table_name
echo row inserted successfully to $table_name	
}
db_name=$1

table_name=$2


if [ -f ./databases/$db_name/$table_name ]; then
file_path=./databases/$db_name/$table_name

first_line=$(sed -n '1p' "$file_path")
echo $first_line
IFS=":" read -ra col_names <<< "$first_line"

second_line=$(sed -n '2p' "$file_path")
echo $second_line
IFS=":" read -ra datatypes <<< "$second_line"

third_line=$(sed -n '3p' "$file_path")
echo $third_line
IFS=":" read -ra constrains <<< "$third_line"

insert_line

else
echo "table not found please enter different table name"
fi
