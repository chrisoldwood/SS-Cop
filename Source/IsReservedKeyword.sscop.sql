/**
 * \file
 * \brief  The IsReservedKeyword user-defined function.
 * \author Chris Oldwood
 */

if (object_id('sscop.IsReservedKeyword') is not null)
	drop function sscop.IsReservedKeyword;
go

/**
 * Queries if the identifier is one of the SQL Server reserved keywords.
 */

create function sscop.IsReservedKeyword
(
	@identifier	sysname		--!< The identifier to validate.
)
	returns bit
as
begin
	if (@identifier is null)
		return null;

	if exists (	select	*
				from	sscop.ReservedKeyword
				where	Word = @identifier )
	begin
		return 1;
	end

	return 0;
end
go
