/**
 * \file
 * \brief  IsPascalCase UDF unit tests.
 * \author Chris Oldwood
 */

create procedure test._@Test@_IsPascalCase_ShouldReturnNull_WhenIdentifierIsNull
as
	declare @actual bit = sscop.IsPascalCase(null);

	exec ssunit.AssertIntegerIsNull @actual;
go

create procedure test._@Test@_IsPascalCase_ShouldReturnFalse_WhenIdentifierIsEmpty
as
	declare @actual bit = sscop.IsPascalCase('');

	exec ssunit.AssertIntegerEqualTo 0, @actual;
go

create procedure test._@Test@_IsPascalCase_ShouldReturnTrue_WhenCasingCorrect
as
	declare @actual bit = sscop.IsPascalCase('PascalCase01');

	exec ssunit.AssertIntegerEqualTo 1, @actual;
go

create procedure test._@Test@_IsPascalCase_ShouldReturnFalse_WhenStartingLetterNotUpperCase
as
	declare @actual bit = sscop.IsPascalCase('camelCase');

	exec ssunit.AssertIntegerEqualTo 0, @actual;
go

create procedure test._@Test@_IsPascalCase_ShouldReturnFalse_WhenIdentifierContainsNonAlphanumerics
as
	declare @actual bit = sscop.IsPascalCase('Pascal_Case');

	exec ssunit.AssertIntegerEqualTo 0, @actual;

	set @actual = sscop.IsPascalCase('Pascal Case');

	exec ssunit.AssertIntegerEqualTo 0, @actual;
go

exec ssunit.RunTests;
