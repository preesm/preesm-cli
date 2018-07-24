@ECHO OFF
REM -- Automates cygwin installation

SETLOCAL

REM -- Change to the directory of the executing batch file
CD %~dp0

if exist cygwin\bin\bash.exe (
    ECHO Skip cygwin setup.
) else (
	REM -- Query architecture 
	reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=x86 || set OS=x86_64

	call .\winhttpjs.bat https://cygwin.com/setup-%OS%.exe -saveTo setup-%OS%.exe
	call .\winhttpjs.bat http://preesm.insa-rennes.fr/setup/setup_cygwin.bat -saveTo setup_cygwin.bat
	call .\setup_cygwin.bat
	ECHO Cygwin successfuly setup.
)

REM -- Prepare PATH variable for bash calls
FOR /F "tokens=* USEBACKQ" %%F IN (`echo %cd%  ^| cygwin\bin\sed.exe "s@\\\\@/@g" ^| cygwin\bin\sed.exe "s@$@/cygwin/bin@g"^| cygwin\bin\sed.exe "s@ @@g" ^| cygwin\bin\sed.exe "s@^\([A-Z]\):@/cygdrive/\L\1@g"`) DO (SET var=%%F)
SET PATH=%var%;%PATH%

ECHO Pause before calling bash
PAUSE

cygwin\bin\bash.exe commandLinePreesm.sh "E:\preesm_CLI\preesm-2.13.0-SNAPSHOT201807240920-win32.win32.x86_64" "E:\preesm_CLI\preesm-tuto" "Codegen.workflow" "03-parasobel_4core.scenario"


ENDLOCAL

EXIT /B 0