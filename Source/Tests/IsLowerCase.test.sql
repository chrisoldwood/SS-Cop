/**
 * \file
 * \brief  IsLowerCase UDF unit tests.
 * \author Chris Oldwood
 */

create procedure test._@Test@_IsLowerCase_ShouldReturnNull_WhenIdentifierIsNull
as
	declare @actual bit = sscop.IsLowerCase(null);

	exec ssunit.AssertIntegerIsNull @actual;
go

create procedure test._@Test@_IsLowerCase_ShouldReturnTrue_WhenIdentifierHasNoUpperCaseLetters
as
	declare @actual bit = sscop.IsLowerCase('lowercase_0');

	exec ssunit.AssertIntegerEqualTo 1, @actual;
go

create procedure test._@Test@_IsLowerCase_ShouldReturnFalse_WhenIdentifierHasUpperCaseLetters
as
	declare @actual bit = sscop.IsLowerCase('UPPERCASE');

	exec ssunit.AssertIntegerEqualTo 0, @actual;
go

create procedure test._@Test@_IsLowerCase_ShouldReturnFalse_WhenIdentifierHasInvalidChars
as
	declare @actual bit = sscop.IsLowerCase('lower case');

	exec ssunit.AssertIntegerEqualTo 0, @actual;
go

exec ssunit.RunTests;
