@echo off
rem ************************************************************
rem
rem Create the SS-Cop objects inside the specified database.
rem
rem ************************************************************

:handle_help_request
if /i "%1" == "-?"     call :usage & exit /b 0
if /i "%1" == "--help" call :usage & exit /b 0

:check_mandatory_args
if /i "%1" == "" call :usage & exit /b 1
if /i "%2" == "" call :usage & exit /b 1

:set_vars
setlocal
setlocal enabledelayedexpansion
set server=%1
set database=%2

echo.
echo ----------------------------------------
echo Installing SS-Cop
echo ----------------------------------------
echo.
for /f "delims=" %%f in (filelist.txt) do (
	echo %%f
	sqlcmd -E -S %server% -d %database% -b -i "%%f"
	if errorlevel 1 (
		echo ERROR: Failed to execute SQL script [!ERRORLEVEL!]
		exit /b 1
	)
)

:success
exit /b 0

rem ************************************************************
rem Functions
rem ************************************************************

:usage
echo.
echo Usage: %~n0 ^<db server^> ^<db name^>
echo.
echo e.g.   %~n0 .\SQLEXPRESS SSCop_Examples
goto :eof