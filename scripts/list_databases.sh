#!/bin/bash

#list every database folder in single line
if [ "$(ls -1 ./databases/ | wc -l)" -eq 0 ]; then
  echo "No Databases found"
else
  ls -1 ./databases/
fi

<<COMMENT
# Display Main menu
select choise in "back to main menu"; do
    case $choise in
    "back to main menu")
        $project_path/run.sh
        ;;
    esac
done
COMMENT
