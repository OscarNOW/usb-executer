@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

echo Please enter the full path of the folder
set /p folder=""

if "!folder:~-1!"=="\" set folder=!folder:~0,-1!
if "!folder:~-1!"=="/" set folder=!folder:~0,-1!

if not exist "!folder!" (
    echo Path doesn't exist
    pause
    goto :eof
    exit
)

xcopy src\ !folder!\ /E /I /H /K /Y /Q

cd icons

echo.
echo Choose icon. Possible values are:
for /r %%A in (*.ico) do (
    echo %%~nA.ico
)
echo.
set /p icon=""

copy "!icon!" "!folder!\hidden\icon.ico"

cd /d "!folder!\"
attrib +R +S +H "File..txt"

echo.
echo.
echo Hidden folder name
set /p hidden=

ren "hidden" "!hidden!"
attrib +R +S +H "!hidden!"

cd "File..txt"

copy File.txt.bat temp3
echo set hidden=!hidden!>File.txt.bat
type temp3 >>File.txt.bat
del temp3

cd ..
cd !hidden!

cd options
for /r %%A in (*) do (
    echo.
    echo Choose value for option '%%~nA'
    echo Possible options are:

    for /F "usebackq tokens=*" %%B in ("%%A") do (
        echo %%B
    )

    echo.
    set /p option=

    echo|set /p=!option!>%%A
)

echo.

cd ..
cd actions

call "remake shortcut.bat"
call "rename file.bat"
call "remake shortcut.bat"

cd ..
start notepad custom.bat