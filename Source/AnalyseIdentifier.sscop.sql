/**
 * \file
 * \brief  The AnalyseIdentifier stored procedure.
 * \author Chris Oldwood
 */

if (object_id('sscop.AnalyseIdentifier') is not null)
	drop procedure sscop.AnalyseIdentifier;
go

/**
 * Checks the identifier against the specified rule.
 */

create procedure sscop.AnalyseIdentifier
(
	@identifier	sysname,		--!< The identifier to be checked.
	@rule		sysname,		--!< The function to invoke for the rule.
	@object		sysname,		--!< The full name of the object being checked.
	@reason		varchar(max)	--!< The reason to use when the check fails.
)
as
	declare @newline varchar(2) = char(13) + char(10),
			@statement varchar(max);

	set	@statement = 'if (' + @rule + '(''' + @identifier + ''') = 0)'                                            + @newline
				   + '    insert into sscop.AnalysisResult values (''' + @object + ''', 0, ''' + @reason + ''');' + @newline
				   + 'else'                                                                                       + @newline
				   + '    insert into sscop.AnalysisResult values (''' + @object + ''', 1, null);'                + @newline

	exec(@statement);
go
