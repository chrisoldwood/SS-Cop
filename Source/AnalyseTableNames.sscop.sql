/**
 * \file
 * \brief  The AnalyseTableNames stored procedure.
 * \author Chris Oldwood
 */

if (object_id('sscop.AnalyseTableNames') is not null)
	drop procedure sscop.AnalyseTableNames;
go

/**
 * Analyses the names of tables in the specified schema.
 */

create procedure sscop.AnalyseTableNames
(
	@schemaId		int,		--!< The schema to analyse.
	@ruleFunction	sysname		--!< The function for validating table names.
)
as
	declare ObjectCursor cursor local fast_forward
	for
	select	t.name
	from	sys.tables t
	where	t.schema_id = @schemaId;

	open ObjectCursor;

	while (1 = 1)
	begin
		declare @name sysname;

		fetch	next
		from	ObjectCursor
		into	@name;

		if (@@fetch_status <> 0)
			break;

		exec sscop.AnalyseIdentifier @identifier = @name,
									 @rule = @ruleFunction,
									 @object = @name,
									 @reason = 'Invalid table name';
	end

	close ObjectCursor;
	deallocate ObjectCursor;
go
