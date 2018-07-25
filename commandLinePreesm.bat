@ECHO OFF

SET PREESMDIR=%1
SET APPDIR=%2
SET WORKFLOW=%3
SET SCENARIO=%4

SETLOCAL

REM -- Change to the directory of the executing batch file
CD %~dp0

if exist cygwin\bin\bash.exe (
    ECHO Skip cygwin setup.
) else (
	REM -- Query architecture 
	IF "%PROCESSOR_ARCHITECTURE%"=="x86" (GOTO 32BIT) ELSE (GOTO 64BIT)
:32BIT
	set bit=x86
	GOTO END
:64BIT
	set bit=x86_64
	GOTO END
:END
	call .\winhttpjs.bat https://cygwin.com/setup-%bit%.exe -saveTo setup-%bit%.exe
	
	REM -- Configure our paths
	SET SITE=http://mirrors.kernel.org/sourceware/cygwin/
	SET LOCALDIR=%LOCALAPPDATA%/cygwin
	SET ROOTDIR=cygwin

	REM -- These are the packages we will install (in addition to the default packages)
	SET PACKAGES=wget,bash,grep

	ECHO *** INSTALLING PACKAGES
	setup-%bit%.exe --no-admin -q -D -L -d -g -o -s "%SITE%" -l "%LOCALDIR%" -R "%ROOTDIR%" -Y -P %PACKAGES%

	REM -- Show what we did
	ECHO.
	ECHO cygwin installation updated
	ECHO  - %PACKAGES%
	ECHO.
	
	DEL setup-%bit%.exe
)

REM -- Prepare PATH variable for bash calls
FOR /F "tokens=* USEBACKQ" %%F IN (`echo %cd%  ^| cygwin\bin\sed.exe "s@\\\\@/@g" ^| cygwin\bin\sed.exe "s@$@/cygwin/bin@g"^| cygwin\bin\sed.exe "s@ @@g" ^| cygwin\bin\sed.exe "s@^\([A-Z]\):@/cygdrive/\L\1@g"`) DO (SET var=%%F)
SET PATH=%var%;%PATH%

REM -- Call Bash script
cygwin\bin\bash.exe commandLinePreesm.sh %PREESMDIR% %APPDIR% %WORKFLOW% %SCENARIO%

ENDLOCAL

EXIT /B 0
