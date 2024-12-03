# fcc_Relational_Db_world_cup_challenge

# Instructions;
# 1. Edit dump sql file from github freecode camp: Comment DROP DATABASE and CREATE DATABASE from sql file
# 2 psql terminal
# 2.1 Connect to postgres: psql -U postgres -h localhost
# 2.2 insert 1010 as password
# 2.3 CREATE DATABASE <database_name>;
# 2.3.1. e.g. CREATE DATABASE worldcup;
# 3. bash terminal
# 3.1. Import sql dump from bash terminal: psql -U <user> -d <database> -f <dump_file.sql>
# 3.1.1 e.g. psql -U postgres -d worldcup -f worldcup.sql
# 4. replace PSQL variable with: export PGPASSWORD=1010 PSQL="psql --username=postgres --dbname=worldcup -t --no-align -c"