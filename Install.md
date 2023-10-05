### Downloading PostgreSQL
First, you will need to install PostgreSQL on your local machine. Select the following three components during installation - PostgreSQL server, pgAdmin, and command-line tools. pgAdmin is a GUI tool for managing the database. Download the installer from the link below, and install with the admin privileges:

* Installing PostgreSQL for Windows: Click and follow the steps mentioned [here](https://www.postgresql.org/download/windows/)


* Installing PostgreSQL for Mac OS: Click
 and follow the steps mentioned [here](https://www.postgresql.org/download/macosx/)

### Friendly reminder 
Please write down the database superuser (postgres) password as you will need it to create the Sakila database once you have installed the PostgreSQL server.

Optionally you can verify the successful installation of PostgreSQL using the following commands in your terminal:

## Server version:
`pg_config --version`
## Client version:
`psql --version`