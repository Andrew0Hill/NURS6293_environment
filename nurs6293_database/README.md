# Initializing NURS6293 Postgres databases

## Purpose
**Creates and populates the initial Postgres database,schemas, and tables for CU-AMC College of Nursing NURS6293 database course.**

## Requirements
* tar
* psql
* Postgres superuser account access (usually user: postgres)
  
## Quick start
* cd `Scripts`
* source `./create_nurs6293_databases.sh`

## Environment
* `PGPASSWORD` the Postgres superuser password. Set in bash script
  
## Validation
* New database: `NURS6293` with owner = student_grp
* New schemas: emr50k, emr100k, install, synthea with owner = student_grp
* All tables in new schemas with owner = student_grp
* Two roles: student with login; student_grp NOLOGIN

# What is performed:
1. Creates two roles: `student_grp` with nologin and `student` with login crediential. These are used to create restricted access for students
2. Creates `nurs6293` database with owner = `student_grp`
3. connects to the `nurs6293` database as role = `student_grp`
4. Creates the four initial schemas:
    *  `install`: Used by students to document successful installation of the course software
    *  `emr100k`: A deidentified encounter-based ambulatory care EMR extract containing 100,000 patients
    *  `emr50k`: A 50% sample of the emr100k database for more efficient query development
    *  `synthea5k`: A 5000 patient database using the simulated data created by the Synthea system (see: https://github.com/synthetichealth/synthea/wiki)
5. Alters the `student_grp` permissions to allow SELECT only access to the above four schemas
6. Alters the `student_grp` permissions to all full CRUD operations on all future schemas/tables
7. Adds the `student` role to the student_grp.    

### Files in this directory:

* `create_nurs6293_databases.sh`: Driver bash script that calls psql to execute the SQL script below.
* `nurse6293_createdb.sql`: Very large SQL script that performs all of the above database operations. Edit this file to change the password for the student user.
* `NURS6293_CREATE_SQL.tar.gz`: Archive file containing the raw SQL commands for creating the database structures (CREATE TABLES) and for filling data using the COPY command. 

**Please report  errors or bugs in Github issues.**
