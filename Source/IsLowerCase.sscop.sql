/**
 * \file
 * \brief  The IsLowerCase user-defined function.
 * \author Chris Oldwood
 */

if (object_id('sscop.IsLowerCase') is not null)
	drop function sscop.IsLowerCase;
go

/**
 * Queries if the identifier only has lower case letters.
 *
 * The identifier can also contain digits and underscores as word separators.
 */

create function sscop.IsLowerCase
(
	@identifier	sysname		--!< The identifier to validate.
)
	returns bit
as
begin
	if (@identifier is null)
		return null;

	if (@identifier like '%[^a-z0-9_]%' collate Latin1_General_BIN)
		return 0;

	return 1;
end
go
