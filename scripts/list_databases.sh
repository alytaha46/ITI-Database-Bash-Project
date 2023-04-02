#!/bin/bash

#list every database folder in single line
ls -1 $project_path/databases/

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
