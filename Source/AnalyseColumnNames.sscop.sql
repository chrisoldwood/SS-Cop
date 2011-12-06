/**
 * \file
 * \brief  The AnalyseColumnNames stored procedure.
 * \author Chris Oldwood
 */

if (object_id('sscop.AnalyseColumnNames') is not null)
	drop procedure sscop.AnalyseColumnNames;
go

/**
 * Analyses the names of columns from all tables in the specified schema.
 */

create procedure sscop.AnalyseColumnNames
(
	@schemaId		int,		--!< The schema to analyse.
	@ruleFunction	sysname		--!< The function for validating column names.
)
as
	declare ObjectCursor cursor local fast_forward
	for
	select	t.name as [table],
			c.name as [name]
	from	sys.columns c
	join	sys.tables t
	on		t.object_id = c.object_id
	where	t.schema_id = @schemaId;

	open ObjectCursor;

	while (1 = 1)
	begin
		declare	@table sysname,
				@name sysname;

		fetch	next
		from	ObjectCursor
		into	@table, @name;

		if (@@fetch_status <> 0)
			break;

		declare @object varchar(max) = @table + '.' + @name;

		exec sscop.AnalyseIdentifier @identifier = @name,
									 @rule = @ruleFunction,
									 @object = @object,
									 @reason = 'Invalid column name';
	end

	close ObjectCursor;
	deallocate ObjectCursor;
go
