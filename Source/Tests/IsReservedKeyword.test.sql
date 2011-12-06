/**
 * \file
 * \brief  IsReservedKeyword UDF unit tests.
 * \author Chris Oldwood
 */

create procedure test._@Test@_IsReservedKeyword_ShouldReturnNull_WhenIdentifierIsNull
as
	declare @actual bit = sscop.IsReservedKeyword(null);

	exec ssunit.AssertIntegerIsNull @actual;
go

create procedure test._@Test@_IsReservedKeyword_ShouldReturnTrue_WhenIdentifierIsKeyword
as
	declare @actual bit = sscop.IsReservedKeyword('SELECT');

	exec ssunit.AssertIntegerEqualTo 1, @actual;
go

create procedure test._@Test@_IsReservedKeyword_ShouldReturnFalse_WhenIdentifierIsNotKeyword
as
	declare @actual bit = sscop.IsReservedKeyword('not a keyword');

	exec ssunit.AssertIntegerEqualTo 0, @actual;
go

exec ssunit.RunTests;
