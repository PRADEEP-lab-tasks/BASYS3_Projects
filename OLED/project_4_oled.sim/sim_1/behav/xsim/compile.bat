@echo off
REM ****************************************************************************
REM Vivado (TM) v2024.1 (64-bit)
REM Filename    : compile.bat
REM Simulator   : AMD Vivado Simulator
REM Description : Script for compiling the simulation design source files
REM usage: compile.bat
REM ****************************************************************************
REM compile Verilog/System Verilog design sources
echo "xvlog --incr --relax -prj top_basys3_oled_adder_vlog.prj"
call xvlog  --incr --relax -prj top_basys3_oled_adder_vlog.prj -log xvlog.log
call type xvlog.log > compile.log
if "%errorlevel%"=="1" goto END
if "%errorlevel%"=="0" goto SUCCESS
:END
exit 1
:SUCCESS
exit 0
