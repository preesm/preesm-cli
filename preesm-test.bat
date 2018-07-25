
REM -- Sample Preesm CLI call

REM -- Change to the directory of the executing batch file
cd %~dp0

call .\commandLinePreesm.bat "E:\preesm_CLI\preesm-2.13.0" "E:\preesm_CLI\preesm-tuto" "Codegen.workflow" "03-parasobel_4core.scenario"

pause
