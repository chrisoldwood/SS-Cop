/**
 * \file
 * \brief  HasSpaces UDF unit tests.
 * \author Chris Oldwood
 */

create procedure test._@Test@_HasSpaces_ShouldReturnNull_WhenIdentifierIsNull
as
	declare @actual bit = sscop.HasSpaces(null);

	exec ssunit.AssertIntegerIsNull @actual;
go

create procedure test._@Test@_HasSpaces_ShouldReturnTrue_WhenIdentifierHasSpaces
as
	declare @actual bit = sscop.HasSpaces('has spaces');

	exec ssunit.AssertIntegerEqualTo 1, @actual;
go

create procedure test._@Test@_HasSpaces_ShouldReturnFalse_WhenIdentifierDoesNotHaveSpaces
as
	declare @actual bit = sscop.HasSpaces('no-spaces');

	exec ssunit.AssertIntegerEqualTo 0, @actual;
go

exec ssunit.RunTests;
