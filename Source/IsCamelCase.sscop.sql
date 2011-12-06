/**
 * \file
 * \brief  The IsCamelCase user-defined function.
 * \author Chris Oldwood
 */

if (object_id('sscop.IsCamelCase') is not null)
	drop function sscop.IsCamelCase;
go

/**
 * Queries if the identifier conforms to the camelCase convention.
 */

create function sscop.IsCamelCase
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

	if (@identifier not like '[a-z]%' collate Latin1_General_BIN)
		return 0;

	if (@identifier like '%[^A-Za-z0-9]%' collate Latin1_General_BIN)
		return 0;

	return 1;
end
go
