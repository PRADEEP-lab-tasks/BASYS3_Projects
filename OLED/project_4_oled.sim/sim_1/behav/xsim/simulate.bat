@echo off
REM ****************************************************************************
REM Vivado (TM) v2024.1 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : AMD Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
REM simulate design
echo "xsim top_basys3_oled_adder_behav -key {Behavioral:sim_1:Functional:top_basys3_oled_adder} -tclbatch top_basys3_oled_adder.tcl -log simulate.log"
call xsim  top_basys3_oled_adder_behav -key {Behavioral:sim_1:Functional:top_basys3_oled_adder} -tclbatch top_basys3_oled_adder.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
