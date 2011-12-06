/**
 * \file
 * \brief  The AnalyseFunctionNames stored procedure.
 * \author Chris Oldwood
 */

if (object_id('sscop.AnalyseFunctionNames') is not null)
	drop procedure sscop.AnalyseFunctionNames;
go

/**
 * Analyses the names of user-defined functions in the specified schema.
 */

create procedure sscop.AnalyseFunctionNames
(
	@schemaId		int,		--!< The schema to analyse.
	@ruleFunction	sysname		--!< The function for validating function names.
)
as
	declare ObjectCursor cursor local fast_forward
	for
	select	f.name
	from	sys.all_objects f
	where	f.type = 'FN'
	and		f.schema_id = @schemaId;

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
									 @reason = 'Invalid function name';
	end

	close ObjectCursor;
	deallocate ObjectCursor;
go
