@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

if 'z%1' NEQ 'z' (
    cd /d "%1"
) else (
    cd ..
    cd !hidden!
)

cscript "execute_2.vbs"
@REM start /min cmd /c execute_3.bat
@REM start cmd /c execute_3.bat
@REM start cmd /k execute_3.bat
exit