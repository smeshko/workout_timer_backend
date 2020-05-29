#!/bin/sh
psql -U postgres << END_OF_SCRIPT

CREATE DATABASE testingdb WITH OWNER = postgres;

\c testingdb

END_OF_SCRIPT
