@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
cd ..

for %%I in (.) do set hidden=%%~nxI

cd ..
for /R "%cd%" %%F in (*.lnk) do (
    set name=%%~nxF
    set name=!name:~0,-4!
)
cd !hidden!

set /p newName="Rename (!name!)->"

cd ..
del "!name!.lnk"
cd !hidden!

ren "!name!.lnk" "!newName!.lnk"
copy "!newName!.lnk" "../!newName!.lnk"

ren "!name:~0,-3!.!name:~-3!/" "!newName:~0,-3!.!newName:~-3!/"
cd "!newName:~0,-3!.!newName:~-3!"
ren "!name!.bat" "!newName!.bat"
cd ..

ren "!name!" "!newName!"
"remake shortcut.bat"