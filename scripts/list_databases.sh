#!/bin/bash

#list every database folder in single line
if [ "$(ls -1 ./databases/ | wc -l)" -eq 0 ]; then
  echo "No Databases found"
else
  ls -1 ./databases/
fi
