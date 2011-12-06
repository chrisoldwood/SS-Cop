/**
 * \file
 * \brief  The AnalyseProcedureNames stored procedure.
 * \author Chris Oldwood
 */

if (object_id('sscop.AnalyseProcedureNames') is not null)
	drop procedure sscop.AnalyseProcedureNames;
go

/**
 * Analyses the names of stored procedures in the specified schema.
 */

create procedure sscop.AnalyseProcedureNames
(
	@schemaId		int,		--!< The schema to analyse.
	@ruleFunction	sysname		--!< The function for validating procedure names.
)
as
	declare ObjectCursor cursor local fast_forward
	for
	select	p.name
	from	sys.procedures p
	where	p.schema_id = @schemaId;

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
									 @reason = 'Invalid procedure name';
	end

	close ObjectCursor;
	deallocate ObjectCursor;
go
