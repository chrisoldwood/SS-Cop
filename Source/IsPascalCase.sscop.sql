/**
 * \file
 * \brief  The IsPascalCase user-defined function.
 * \author Chris Oldwood
 */

if (object_id('sscop.IsPascalCase') is not null)
	drop function sscop.IsPascalCase;
go

/**
 * Queries if the identifier conforms to the PascalCase convention.
 */

create function sscop.IsPascalCase
(
	@identifier	sysname		--!< The identifier to validate.
)
	returns bit
as
begin
	if (@identifier is null)
		return null;

	declare @length int = len(@identifier);

	if (@length = 0)
		return 0;

	if (@identifier not like '[A-Z]%' collate Latin1_General_BIN)
		return 0;

	if (@identifier like '%[^A-Za-z0-9]%' collate Latin1_General_BIN)
		return 0;

	return 1;
end
go
