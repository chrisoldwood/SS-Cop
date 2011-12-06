/**
 * \file
 * \brief  The Analyse procedure unit tests.
 * \author Chris Oldwood
 */

create procedure test._@TestSetUp@_$Analyse$_
as
	exec test._@TestTearDown@_$Analyse$_;

	create table test.Analyse_Result
	(
		ObjectName		sysname			not null,
		FailureReason	varchar(max)	not null,
	);
go

create procedure test._@TestTearDown@_$Analyse$_
as
	if (object_id('test.Analyse_Result') is not null)
		drop table test.Analyse_Result;

	if (object_id('dbo.AnyTable') is not null)
		drop table dbo.AnyTable;

	if (object_id('dbo.camelCasedTable') is not null)
		drop table dbo.camelCasedTable;
go

if (object_id('dbo.camelCasedProcedure') is not null)
	drop procedure dbo.camelCasedProcedure;
go

create procedure dbo.camelCasedProcedure
	@camelCasedParameter int
as
	--
go

if (object_id('dbo.PascalCasedProcedure') is not null)
	drop procedure dbo.PascalCasedProcedure;
go

create procedure dbo.PascalCasedProcedure
	@PascalCasedParameter int
as
	--
go

if (object_id('dbo.camelCasedFunction') is not null)
	drop function dbo.camelCasedFunction;
go

create function dbo.camelCasedFunction
(
	@camelCasedParameter int
)
	returns int
as
begin
	return 42;
end
go

if (object_id('dbo.PascalCasedFunction') is not null)
	drop function dbo.PascalCasedFunction;
go

create function dbo.PascalCasedFunction
(
	@PascalCasedParameter int
)
	returns int
as
begin
	return 42;
end
go

create procedure test._@Test@_$Analyse$_ShouldNotAnalyseTables_WhenTableNameRuleIsNull
as
	create table dbo.AnyTable
	(
		AnyColumn	int
	);

	insert into test.Analyse_Result
	exec sscop.Analyse	@schemaName = 'dbo',
						@tableNameRule = null;

	declare @count int;
	select	@count = count(*) from test.Analyse_Result

	exec ssunit.AssertIntegerEqualTo 0, @count;
go

create procedure test._@Test@_$Analyse$_ShouldReportTableName_WhenRuleFails
as
	create table dbo.camelCasedTable
	(
		camelCasedColumn	int
	);

	insert into test.Analyse_Result
	exec sscop.Analyse	@schemaName = 'dbo',
						@tableNameRule = 'sscop.IsPascalCase';

	declare @count int;
	select	@count = count(*) from test.Analyse_Result

	exec ssunit.AssertIntegerEqualTo 1, @count;

	declare @object sysname;
	select	@object = ObjectName from test.Analyse_Result

	exec ssunit.AssertStringEqualTo 'camelCasedTable', @object;
go

create procedure test._@Test@_$Analyse$_ShouldNotAnalyseColumns_WhenColumnNameRuleIsNull
as
	create table dbo.AnyTable
	(
		AnyColumn	int
	);

	insert into test.Analyse_Result
	exec sscop.Analyse	@schemaName = 'dbo',
						@columnNameRule = null;

	declare @count int;
	select	@count = count(*) from test.Analyse_Result

	exec ssunit.AssertIntegerEqualTo 0, @count;
go

create procedure test._@Test@_$Analyse$_ShouldReportTableAndColumnName_WhenRuleFails
as
	create table dbo.camelCasedTable
	(
		camelCasedColumn	int,
		PascalCasedColumn	int
	);

	insert into test.Analyse_Result
	exec sscop.Analyse	@schemaName = 'dbo',
						@columnNameRule = 'sscop.IsPascalCase';

	declare @count int;
	select	@count = count(*) from test.Analyse_Result

	exec ssunit.AssertIntegerEqualTo 1, @count;

	declare @object sysname;
	select	@object = ObjectName from test.Analyse_Result

	exec ssunit.AssertStringEqualTo 'camelCasedTable.camelCasedColumn', @object;
go

create procedure test._@Test@_$Analyse$_ShouldNotAnalyseProcedures_WhenProcedureNameRuleIsNull
as
	insert into test.Analyse_Result
	exec sscop.Analyse	@schemaName = 'dbo',
						@procedureNameRule = null;

	declare @count int;
	select	@count = count(*) from test.Analyse_Result

	exec ssunit.AssertIntegerEqualTo 0, @count;
go

create procedure test._@Test@_$Analyse$_ShouldReportProcedureName_WhenRuleFails
as
	insert into test.Analyse_Result
	exec sscop.Analyse	@schemaName = 'dbo',
						@procedureNameRule = 'sscop.IsPascalCase';

	declare @count int;
	select	@count = count(*) from test.Analyse_Result

	exec ssunit.AssertIntegerEqualTo 1, @count;

	declare @object sysname;
	select	@object = ObjectName from test.Analyse_Result

	exec ssunit.AssertStringEqualTo 'camelCasedProcedure', @object;
go

create procedure test._@Test@_$Analyse$_ShouldNotAnalyseFunctions_WhenFunctionNameRuleIsNull
as
	insert into test.Analyse_Result
	exec sscop.Analyse	@schemaName = 'dbo',
						@functionNameRule = null;

	declare @count int;
	select	@count = count(*) from test.Analyse_Result

	exec ssunit.AssertIntegerEqualTo 0, @count;
go

create procedure test._@Test@_$Analyse$_ShouldReportFunctionName_WhenRuleFails
as
	insert into test.Analyse_Result
	exec sscop.Analyse	@schemaName = 'dbo',
						@functionNameRule = 'sscop.IsPascalCase';

	declare @count int;
	select	@count = count(*) from test.Analyse_Result

	exec ssunit.AssertIntegerEqualTo 1, @count;

	declare @object sysname;
	select	@object = ObjectName from test.Analyse_Result

	exec ssunit.AssertStringEqualTo 'camelCasedFunction', @object;
go

create procedure test._@Test@_$Analyse$_ShouldNotAnalyseParameters_WhenParameterNameRuleIsNull
as
	insert into test.Analyse_Result
	exec sscop.Analyse	@schemaName = 'dbo',
						@parameterNameRule = null;

	declare @count int;
	select	@count = count(*) from test.Analyse_Result

	exec ssunit.AssertIntegerEqualTo 0, @count;
go

create procedure test._@Test@_$Analyse$_ShouldReportProcedureAndParameterName_WhenRuleFails
as
	insert into test.Analyse_Result
	exec sscop.Analyse	@schemaName = 'dbo',
						@parameterNameRule = 'sscop.IsPascalCase';

	declare @count int;
	select	@count = count(*) from test.Analyse_Result

	exec ssunit.AssertIntegerEqualTo 2, @count;

	declare @object sysname;
	select	top 1 @object = ObjectName from test.Analyse_Result order by ObjectName asc

	exec ssunit.AssertStringEqualTo 'camelCasedFunction.@camelCasedParameter', @object;

	select	top 1 @object = ObjectName from test.Analyse_Result order by ObjectName desc

	exec ssunit.AssertStringEqualTo 'camelCasedProcedure.@camelCasedParameter', @object;
go

exec ssunit.RunTests;
