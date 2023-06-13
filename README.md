# ITI-Database-Bash-Project 

The Bash Shell Script DBMS is a command-line interface (CLI) application that allows users to store and retrieve data from the hard disk. It provides a simple menu-based system for managing databases, tables, and performing data operations.

## Project Features

The application offers the following features:

### Main Menu

- Create Database: Allows users to create a new database.
- List Databases: Displays a list of existing databases.
- Connect to Database: Connects the user to a specific database.
- Drop Database: Deletes a database and its associated files.
- Exit: Exits the application.

### Connected Database Menu

Once connected to a database, the user has access to the following options:

- List Tables: Displays a list of tables in the connected database.
- Create Table: Allows users to create a new table in the connected database.
- Insert into Table: Inserts data into a table.
- Select From Table: Retrieves data from a table.
- Select From Table GUI: Retrieves data from a table using a graphical user interface (GUI).
- Update Table: Updates data in a table.
- Delete From Table: Deletes data from a table.
- Drop Table: Deletes a table from the connected database.
- Back: Returns to the main menu.

## Implementation Details

- Databases are stored as directories within the current script file.
- Data selection from tables is displayed in an accepted/good format.
- Column datatypes are validated during table creation, insertions, and updates.
- Primary key constraints can be defined during table creation and enforced during insertions.

## Usage

1. Clone the repository.
2. Navigate to the project directory.
3. Run the main script to start the application.
4. Follow the menu prompts to interact with the DBMS.

## Contributing

Contributions are welcome! If you have any suggestions or improvements for this project, please feel free to submit a pull request.

