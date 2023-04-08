#!/bin/bash

database_name=$1
table_name=$2
database_path="./databases/$database_name"
table_path="$database_path/$table_name"
# Function to print a row with formatted columns
print_row() {
    col_len=()
    row=()
    number=$#
    number=$((number - 1))
    x=1
    for arg in "$@"; do
        if [ $x -eq $# ]; then
            row+=$arg
        else
            col_len+=("$arg")
        fi
        x=$((x + 1))
    done
    IFS=":" read -ra columns <<<"$row"

    # Save elements into the array
    local table_header=""
    for ((k = 0; k < $number; k++)); do
        table_header+="| ${columns[$k]} "
        for ((j = ${#columns[$k]}; j < ${col_len[$k]}; j++)); do
            table_header+=" "
        done
    done
    table_header+="|"
    local table_separator=$(printf "+-%*s-+" $((${#table_header} - 4)) "")

    #echo "$table_separator"
    echo "$table_header"
    #echo "$table_separator"

}

# Declare an empty array to hold the file contents
data=()
gui() {
    # Read the file line by line and append each line to the array
    line_number=1
    while IFS= read -r line; do
        if [[ $line_number -eq 1 ]]; then
            data+=("$line")
        elif [[ $line_number -ge 4 ]]; then
            data+=("$line")
        fi
        # Increment the line number counter
        line_number=$((line_number + 1))
    done <$table_path

    # Get the maximum length of data in each column
    max_lengths=()
    for ((i = 0; i < ${#data[@]}; i++)); do
        IFS=":"
        row=(${data[$i]})
        unset IFS
        for ((j = 0; j < ${#row[@]}; j++)); do
            length=${#row[$j]}
            if ((i == 0)); then
                max_lengths+=($length)
            elif ((length > max_lengths[j])); then
                max_lengths[j]=$length
            fi
        done
    done

    # Print the separator row
    separator="+"
    for ((i = 0; i < ${#max_lengths[@]}; i++)); do
        for ((j = 0; j < max_lengths[i] + 2; j++)); do
            separator+="-"
        done
        separator+="+"
    done
    echo $separator

    # Print the table header
    print_row "${max_lengths[@]}" "${data[0]}"

    # Print the separator row
    separator="+"
    for ((i = 0; i < ${#max_lengths[@]}; i++)); do
        for ((j = 0; j < max_lengths[i] + 2; j++)); do
            separator+="-"
        done
        separator+="+"
    done
    echo $separator

    for ((i = 1; i < ${#data[@]}; i++)); do
        print_row "${max_lengths[@]}" "${data[i]}"
    done

    # Print the separator row
    separator="+"
    for ((i = 0; i < ${#max_lengths[@]}; i++)); do
        for ((j = 0; j < max_lengths[i] + 2; j++)); do
            separator+="-"
        done
        separator+="+"
    done
    echo $separator
    # Loop through the data and print each row
    #for ((i = 1; i < ${#data[@]}; i++)); do
    # Split the row into columns using ":" as the delimiter
    #  IFS=":"
    #   row=(${data[$i]})

    # Print the row
    #  echo ${max_lengths[@]}
    # echo ${row[@]}

    #print_row "${max_lengths[@]}" "${row[@]}"
    #done

}
# check if table exists
if [ -f $table_path ]; then
    gui
else
    echo table $2 not found
fi
