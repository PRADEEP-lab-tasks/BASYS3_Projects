@echo off

rem  Vivado (TM)
rem  runme.bat: a Vivado-generated Script
set HD_SDIR=%~dp0
cd /d "%HD_SDIR%"
cscript /nologo /E:JScript "%HD_SDIR%\rundef.js" %*
