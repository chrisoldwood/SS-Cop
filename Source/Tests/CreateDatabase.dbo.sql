/**
 * \file
 * \brief  Creates the SQL-Cop unit test database.
 * \author Chris Oldwood
 */

if (db_id('SQL_Cop_Tests')  is not null)
	drop database SQL_Cop_Tests;
go

create database SQL_Cop_Tests;
go
