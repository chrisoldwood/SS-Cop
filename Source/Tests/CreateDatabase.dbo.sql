/**
 * \file
 * \brief  Creates the SS-Cop unit test database.
 * \author Chris Oldwood
 */

if (db_id('SSCop_Tests')  is not null)
	drop database SSCop_Tests;
go

create database SSCop_Tests;
go
