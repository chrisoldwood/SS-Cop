/**
 * \file
 * \brief  The AnalyseParameterNames stored procedure.
 * \author Chris Oldwood
 */

if (object_id('sscop.AnalyseParameterNames') is not null)
	drop procedure sscop.AnalyseParameterNames;
go

/**
 * Analyses the names of parameters from all stored procedures in the specified
 * schema.
 *
 * NB: Parameter names contain an addtional leading '@' character so we strip
 * that here to allow the comparison functions to be identifier-type agnostic.
 */

create procedure sscop.AnalyseParameterNames
(
	@schemaId		int,		--!< The schema to analyse.
	@ruleFunction	sysname		--!< The function for validating parameter names.
)
as
	declare ObjectCursor cursor local fast_forward
	for
	select	o.name as [object],
			a.name as [name]
	from	sys.parameters a
	join	sys.all_objects o
	on		o.object_id = a.object_id
	and		o.type in ('FN', 'P')
	and		a.parameter_id <> 0
	where	o.schema_id = @schemaId;

	open ObjectCursor;

	while (1 = 1)
	begin
		declare	@callable sysname,
				@name sysname;

		fetch	next
		from	ObjectCursor
		into	@callable, @name;

		if (@@fetch_status <> 0)
			break;

		declare @object varchar(max) = @callable + '.' + @name;

		if (@name like '@%')
			set @name = substring(@name, 2, len(@name)-1);

		exec sscop.AnalyseIdentifier @identifier = @name,
									 @rule = @ruleFunction,
									 @object = @object,
									 @reason = 'Invalid parameter name';
	end

	close ObjectCursor;
	deallocate ObjectCursor;
go
