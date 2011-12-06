/**
 * \file
 * \brief  The ReservedKeyword table.
 * \author Chris Oldwood
 */

if (object_id('sscop.ReservedKeyword') is not null)
	drop table sscop.ReservedKeyword;
go

/**
 * The table of SQL Server reserved keywords.
 */

create table sscop.ReservedKeyword
(
	--! The reserved word.
	Word sysname not null primary key clustered,
);
go

/*
 * This list comes from SQL Server 2008 R2 Books Online.
 */

set nocount on;

insert into sscop.ReservedKeyword(Word)
          select 'ADD'
union all select 'ALL'
union all select 'ALTER'
union all select 'AND'
union all select 'ANY'
union all select 'AS'
union all select 'ASC'
union all select 'AUTHORIZATION'
union all select 'BACKUP'
union all select 'BEGIN'
union all select 'BETWEEN'
union all select 'BREAK'
union all select 'BROWSE'
union all select 'BULK'
union all select 'BY'
union all select 'CASCADE'
union all select 'CASE'
union all select 'CHECK'
union all select 'CHECKPOINT'
union all select 'CLOSE'
union all select 'CLUSTERED'
union all select 'COALESCE'
union all select 'COLLATE'
union all select 'COLUMN'
union all select 'COMMIT'
union all select 'COMPUTE'
union all select 'CONSTRAINT'
union all select 'CONTAINS'
union all select 'CONTAINSTABLE'
union all select 'CONTINUE'
union all select 'CONVERT'
union all select 'CREATE'
union all select 'CROSS'
union all select 'CURRENT'
union all select 'CURRENT_DATE'
union all select 'CURRENT_TIME'
union all select 'CURRENT_TIMESTAMP'
union all select 'CURRENT_USER'
union all select 'CURSOR'
union all select 'DATABASE'
union all select 'DBCC'
union all select 'DEALLOCATE'
union all select 'DECLARE'
union all select 'DEFAULT'
union all select 'DELETE'
union all select 'DENY'
union all select 'DESC'
union all select 'DISK'
union all select 'DISTINCT'
union all select 'DISTRIBUTED'
union all select 'DOUBLE'
union all select 'DROP'
union all select 'DUMP'
union all select 'ELSE'
union all select 'END'
union all select 'ERRLVL'
union all select 'ESCAPE'
union all select 'EXCEPT'
union all select 'EXEC'
union all select 'EXECUTE'
union all select 'EXISTS'
union all select 'EXIT'
union all select 'EXTERNAL'
union all select 'FETCH'
union all select 'FILE'
union all select 'FILLFACTOR'
union all select 'FOR'
union all select 'FOREIGN'
union all select 'FREETEXT'
union all select 'FREETEXTTABLE'
union all select 'FROM'
union all select 'FULL'
union all select 'FUNCTION'
union all select 'GOTO'
union all select 'GRANT'
union all select 'GROUP'
union all select 'HAVING'
union all select 'HOLDLOCK'
union all select 'IDENTITY'
union all select 'IDENTITY_INSERT'
union all select 'IDENTITYCOL'
union all select 'IF'
union all select 'IN'
union all select 'INDEX'
union all select 'INNER'
union all select 'INSERT'
union all select 'INTERSECT'
union all select 'INTO'
union all select 'IS'
union all select 'JOIN'
union all select 'KEY'
union all select 'KILL'
union all select 'LEFT'
union all select 'LIKE'
union all select 'LINENO'
union all select 'LOAD'
union all select 'MERGE'
union all select 'NATIONAL'
union all select 'NOCHECK '
union all select 'NONCLUSTERED'
union all select 'NOT'
union all select 'NULL'
union all select 'NULLIF'
union all select 'OF'
union all select 'OFF'
union all select 'OFFSETS'
union all select 'ON'
union all select 'OPEN'
union all select 'OPENDATASOURCE'
union all select 'OPENQUERY'
union all select 'OPENROWSET'
union all select 'OPENXML'
union all select 'OPTION'
union all select 'OR'
union all select 'ORDER'
union all select 'OUTER'
union all select 'OVER'
union all select 'PERCENT'
union all select 'PIVOT'
union all select 'PLAN'
union all select 'PRECISION'
union all select 'PRIMARY'
union all select 'PRINT'
union all select 'PROC'
union all select 'PROCEDURE'
union all select 'PUBLIC'
union all select 'RAISERROR'
union all select 'READ'
union all select 'READTEXT'
union all select 'RECONFIGURE'
union all select 'REFERENCES'
union all select 'REPLICATION'
union all select 'RESTORE'
union all select 'RESTRICT'
union all select 'RETURN'
union all select 'REVERT'
union all select 'REVOKE'
union all select 'RIGHT'
union all select 'ROLLBACK'
union all select 'ROWCOUNT'
union all select 'ROWGUIDCOL'
union all select 'RULE'
union all select 'SAVE'
union all select 'SCHEMA'
union all select 'SECURITYAUDIT'
union all select 'SELECT'
union all select 'SESSION_USER'
union all select 'SET'
union all select 'SETUSER'
union all select 'SHUTDOWN'
union all select 'SOME'
union all select 'STATISTICS'
union all select 'SYSTEM_USER'
union all select 'TABLE'
union all select 'TABLESAMPLE'
union all select 'TEXTSIZE'
union all select 'THEN'
union all select 'TO'
union all select 'TOP'
union all select 'TRAN'
union all select 'TRANSACTION'
union all select 'TRIGGER'
union all select 'TRUNCATE'
union all select 'TSEQUAL'
union all select 'UNION'
union all select 'UNIQUE'
union all select 'UNPIVOT'
union all select 'UPDATE'
union all select 'UPDATETEXT'
union all select 'USE'
union all select 'USER'
union all select 'VALUES'
union all select 'VARYING'
union all select 'VIEW'
union all select 'WAITFOR'
union all select 'WHEN'
union all select 'WHERE'
union all select 'WHILE'
union all select 'WITH'
union all select 'WRITETEXT'
