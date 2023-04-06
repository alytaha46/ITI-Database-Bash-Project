#!/bin/bash

# enable regex in bash
shopt -s extglob

db_name=$1

table_name=$2


if [ -f ./databases/$db_name/$table_name ]; then
echo "table name already exists choose a different table name"
else
            
# Prompt the user for the array size
read -p "Enter number of columns : " size

# Create three arrays of the same size as the input
declare -a column_names=()
declare -a datatypes=()
declare -a constrains=()

echo "please enter PK column name: " 
while read pk_name; do
if [[ $pk_name =~ ^([a-zA-Z_])[a-zA-Z0-9_]*$ ]]; then
  column_names[0]=$pk_name
  break
else
  echo "invalid column name"
fi
done

datatypes[0]="int"
constrains[0]="PK"
for ((i=1; i<$size; i++)); do
  # Loop through the arrays simultaneously and take user inputs
  echo "Enter column name number $((i+1)): "
  while read elem1; do
if [[ $elem1 =~ ^([a-zA-Z_])[a-zA-Z0-9_]*$ ]]; then
  column_names[$i]=$elem1
  break
else
  echo "pk_name does not match the regex pattern."
fi
done


  echo "Enter datatype of column number $((i+1)): "
	select elem2 in "string" "int"; do
	case "$elem2" in 
	  "string")
	    echo "string"
	    datatypes[$i]="string"
	    break
	    ;;
	  "int")
	    echo "int"
	    datatypes[$i]="int"
	    break
	    ;;
	  *)
	    echo "invalid"
	    ;;
	esac
	done

echo "Enter constrains of column number $((i+1)): "
	select elem3 in "Null" "not null"; do
	case "$elem3" in 
	  "Null")
	    echo "Null"
	    constrains[$i]="NULL"
	    break
	    ;;
	  "not null")
	    echo "not null"
	    constrains[$i]="NOT_NULL"
	    break
	    ;;
	  *)
	    echo "invalid"
	    ;;
	esac
	done
  	
done
line1=""
line2=""
line3=""
for element in "${column_names[@]}"; do
  line1+="$element:"
done
line1=${line1%?}
echo $line1 >> ./databases/$db_name/$table_name

for element in "${datatypes[@]}"; do
  line2+="$element:"
done
line2=${line2%?}
echo $line2 >> ./databases/$db_name/$table_name 

for element in "${constrains[@]}"; do
  line3+="$element:"
done
line3=${line3%?}
echo $line3 >> ./databases/$db_name/$table_name

echo table $table_name created successfully		
fi

