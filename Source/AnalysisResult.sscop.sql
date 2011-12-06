/**
 * \file
 * \brief  The AnalysisResult table.
 * \author Chris Oldwood
 */

if (object_id('sscop.AnalysisResult') is not null)
	drop table sscop.AnalysisResult;
go

/**
 * The table that stores the results each object analysed.
 */

create table sscop.AnalysisResult
(
	--! The name of the object analysed.
	ObjectName sysname not null,

	--! The analysis result.
	HasPassed bit not null,

	--! The reason the analysis failed.
	FailureReason varchar(max) null,	
);
go
