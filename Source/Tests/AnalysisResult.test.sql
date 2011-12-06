/**
 * \file
 * \brief  The AnalysisResult table and procedure unit tests.
 * \author Chris Oldwood
 */

create procedure test._@Test@_$AnalysisResult$_Clear_ShouldEmptyTheTable
as
	insert into sscop.AnalysisResult(ObjectName, HasPassed, FailureReason)
                              values('unittest', 0,         'failed');

	exec sscop.AnalysisResult_Clear;

	declare @count int;
	select	@count = count(*) from sscop.AnalysisResult;

	exec ssunit.AssertIntegerEqualTo 0, @count;
go

exec ssunit.RunTests;
