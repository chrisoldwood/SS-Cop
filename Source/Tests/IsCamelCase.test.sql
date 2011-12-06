/**
 * \file
 * \brief  IsCamelCase UDF unit tests.
 * \author Chris Oldwood
 */

create procedure test._@Test@_IsCamelCase_ShouldReturnNull_WhenIdentifierIsNull
as
	declare @actual bit = sscop.IsCamelCase(null);

	exec ssunit.AssertIntegerIsNull @actual;
go

create procedure test._@Test@_IsCamelCase_ShouldReturnFalse_WhenIdentifierIsEmpty
as
	declare @actual bit = sscop.IsCamelCase('');

	exec ssunit.AssertIntegerEqualTo 0, @actual;
go

create procedure test._@Test@_IsCamelCase_ShouldReturnTrue_WhenCasingCorrect
as
	declare @actual bit = sscop.IsCamelCase('camelCase');

	exec ssunit.AssertIntegerEqualTo 1, @actual;
go

create procedure test._@Test@_IsCamelCase_ShouldReturnFalse_WhenStartingLetterNotLowerCase
as
	declare @actual bit = sscop.IsCamelCase('PascalCase');

	exec ssunit.AssertIntegerEqualTo 0, @actual;
go

create procedure test._@Test@_IsPascalCase_ShouldReturnFalse_WhenIdentifierContainsNonAlphanumerics
as
	declare @actual bit = sscop.IsCamelCase('camel_Case');

	exec ssunit.AssertIntegerEqualTo 0, @actual;

	set @actual = sscop.IsCamelCase('camel Case');

	exec ssunit.AssertIntegerEqualTo 0, @actual;
go

exec ssunit.RunTests;
