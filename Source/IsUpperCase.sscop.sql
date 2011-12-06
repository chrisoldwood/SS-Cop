/**
 * \file
 * \brief  The IsUpperCase user-defined function.
 * \author Chris Oldwood
 */

if (object_id('sscop.IsUpperCase') is not null)
	drop function sscop.IsUpperCase;
go

/**
 * Queries if the identifier only has upper case letters.
 *
 * The identifier can also contain digits and underscores as word separators.
 */

create function sscop.IsUpperCase
(
	@identifier	sysname		--!< The identifier to validate.
)
	returns bit
as
begin
	if (@identifier is null)
		return null;

	if (@identifier like '%[^A-Z0-9_]%' collate Latin1_General_BIN)
		return 0;

	return 1;
end
go
