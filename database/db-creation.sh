#! /bin/bash

psql < creation_script.sql
psql just_meat < dump.sql
