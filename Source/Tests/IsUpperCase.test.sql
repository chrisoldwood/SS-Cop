/**
 * \file
 * \brief  IsUpperCase UDF unit tests.
 * \author Chris Oldwood
 */

create procedure test._@Test@_IsUpperCase_ShouldReturnNull_WhenIdentifierIsNull
as
	declare @actual bit = sscop.IsUpperCase(null);

	exec ssunit.AssertIntegerIsNull @actual;
go

create procedure test._@Test@_IsUpperCase_ShouldReturnTrue_WhenIdentifierHasNoLowerCaseLetters
as
	declare @actual bit = sscop.IsUpperCase('UPPER_CASE_0');

	exec ssunit.AssertIntegerEqualTo 1, @actual;
go

create procedure test._@Test@_IsUpperCase_ShouldReturnFalse_WhenIdentifierHasLowerCaseLetters
as
	declare @actual bit = sscop.IsUpperCase('lowercase');

	exec ssunit.AssertIntegerEqualTo 0, @actual;
go

create procedure test._@Test@_IsUpperCase_ShouldReturnFalse_WhenIdentifierHasInvalidChars
as
	declare @actual bit = sscop.IsUpperCase('UPPER CASE');

	exec ssunit.AssertIntegerEqualTo 0, @actual;
go

exec ssunit.RunTests;
