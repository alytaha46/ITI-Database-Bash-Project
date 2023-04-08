#!/bin/bash

#list every database folder in single line
if [ "$(ls -1 ./databases/ | wc -l)" -eq 0 ]; then
  echo "No Databases found"
else
  counter=1
  for database_name in $(ls -1 ./databases/)
  do
    echo "$counter) $database_name"
    counter=$((counter+1))
  done
fi
