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
declare -a array1=()
declare -a array2=()
declare -a array3=()

for ((i=0; i<$size; i++)); do
  # Loop through the arrays simultaneously and take user inputs
  read -p "Enter element $i for array 1: " elem1
  read -p "Enter element $i for array 2: " elem2
  read -p "Enter element $i for array 3: " elem3

  # Save the inputs to the corresponding arrays
  array1[$i]=$elem1
  array2[$i]=$elem2
  array3[$i]=$elem3
done

# Print the contents of the arrays for verification
echo "Array 1: ${array1[@]}"
echo "Array 2: ${array2[@]}"
echo "Array 3: ${array3[@]}"


touch "./databases/$db_name/$table_name"	
echo table $table_name created successfully
            
fi

table file structure
#line 1
columns name colon separated ( id:f_name:l_name:address:salary )
# line 2
datatypes colon separated (int:string:string:string:int)
#line 3
constrains colon separated (PK:NOT_NULL:NOT_NULL:NULL:NULL:NULL)  => empty means no constrains
# line 4
begining of data (1:aly:taha:asyout:20000)
