-- Drop existing database and user
DROP DATABASE IF EXISTS just_meat;
DROP USER IF EXISTS admin;

-- Create user and db
CREATE USER admin WITH password 'admin';
ALTER USER admin WITH superuser;
ALTER USER admin WITH createdb;
CREATE DATABASE just_meat WITH ENCODING 'UTF8';
ALTER database just_meat OWNER TO admin;