/**
 * \file
 * \brief  The AnalysisResult_Clear stored procedure.
 * \author Chris Oldwood
 */

if (object_id('sscop.AnalysisResult_Clear') is not null)
	drop procedure sscop.AnalysisResult_Clear;
go

/**
 * Clears the table of analysis results.
 */

create procedure sscop.AnalysisResult_Clear
as
	begin transaction;

	truncate table sscop.AnalysisResult;

	commit transaction;
go
