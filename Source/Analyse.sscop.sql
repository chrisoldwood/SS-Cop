/**
 * \file
 * \brief  The Analyse stored procedure.
 * \author Chris Oldwood
 */

if (object_id('sscop.Analyse') is not null)
	drop procedure sscop.Analyse;
go

/**
 * Performs an analysis of the objects in the specified schema.
 */

create procedure sscop.Analyse
(
	@schemaName			sysname,			--!< The schema to analyse.
	@tableNameRule		sysname = null,		--!< The function for validating table names.
	@columnNameRule		sysname = null,		--!< The function for validating column names.
	@procedureNameRule	sysname = null,		--!< The function for validating procedure names.
	@functionNameRule	sysname = null,		--!< The function for validating function names.
	@parameterNameRule	sysname = null		--!< The function for validating parameter names.
)
as
	-- Clear out any old results.
	exec sscop.AnalysisResult_Clear;

	-- Find the ID of the schema.
	declare	@schemaId int;

	select	@schemaId = s.schema_id
	from	sys.schemas s
	where	s.name = @schemaName;

	-- Analyse objects
	if (@tableNameRule is not null)
		exec sscop.AnalyseTableNames @schemaId, @tableNameRule;

	if (@columnNameRule is not null)
		exec sscop.AnalyseColumnNames @schemaId, @columnNameRule;

	if (@procedureNameRule is not null)
		exec sscop.AnalyseProcedureNames @schemaId, @procedureNameRule;

	if (@functionNameRule is not null)
		exec sscop.AnalyseFunctionNames @schemaId, @functionNameRule;

	if (@parameterNameRule is not null)
		exec sscop.AnalyseParameterNames @schemaId, @parameterNameRule;

	-- Format results
	select	convert(varchar(40), ar.ObjectName)		as [ObjectName],
			convert(varchar(38), ar.FailureReason)	as [FailureReason]
	from	sscop.AnalysisResult ar
	where	ar.HasPassed = 0;
go
