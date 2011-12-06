/**
 * \file
 * \brief  The HasSpaces user-defined function.
 * \author Chris Oldwood
 */

if (object_id('sscop.HasSpaces') is not null)
	drop function sscop.HasSpaces;
go

/**
 * Queries if the identifier has spaces in it.
 */

create function sscop.HasSpaces
(
	@identifier	sysname		--!< The identifier to validate.
)
	returns bit
as
begin
	if (@identifier is null)
		return null;

	if (@identifier like '% %' collate Latin1_General_BIN)
		return 1;

	return 0;
end
go
