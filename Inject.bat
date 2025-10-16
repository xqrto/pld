::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFCJbWRaxJXiuA7ggzOfs4eaIo0kOaOs8d4HIgvmPLvcW5EHxe5FggiIUkcgDbA==
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdFu5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFCJbWRaxJXiuA7ggzO3o5P6IsnEUWug6e5vUyPqLOOVz
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
if not exist %~dp0data goto makeall
cd "%~dp0"
:stt
color c
echo off
set "totl=%random%%random%%random%"
title %totl%
setlocal enabledelayedexpansion
echo %~dp0data\temp\bin\xylo.exe > "%~dp0data\src\path.var"
set /p PRname=< %~dp0data\proc.txt
if exist %1 goto add
cls

set "GUIPATH=%~dp0data\temp\GUI.html"
set "CHOICEFILE=%~dp0choice.var"
if exist "%CHOICEFILE%" del "%CHOICEFILE%" >nul 2>&1
cls
echo DLL:
dir "%~dp0data\dlls" /b
echo.
echo Process:
echo (%PRname%)
start /wait "" mshta.exe "%GUIPATH%"

ping _n 1 >NUL

set /p menu=<"%~dp0choice.var"
del "%~dp0choice.var" /Q


if %menu%== 1 goto start
if %menu%== 2 goto mkproc
if %menu%== 3 goto removedll
if %menu%== 4 goto adddlll
if %menu%== 5 goto abt

echo Keine Auswahl getroffen.
exit /b

{
    :start
    goto main
    [
        {
            :main
            goto Settings
        }
        {
            :add
            if %~x1 == .dll goto adddll
            goto extdismatch
            [
                {
                    :adddll
                    copy "%1" /ziel "%~dp0data\dlls\%~nx1" /Y
                    goto end
                }
                {

                    :extdismatch
                    echo %~nx1 is not a dll
                    goto end
                }
            ]
        }
    ]
}
[
:Settings
if exist "%~dp0data\proc.txt" goto prok
goto mkproc
:prok
set /p proc=< "%~dp0data\proc.txt"
call "%~dp0data\src\get"
goto inject
]
:mkproc
cls
echo enter Process name
echo (notepad.exe)
for /f "usebackq delims=" %%i in (`powershell -NoProfile -Command "[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic'); [Microsoft.VisualBasic.Interaction]::InputBox('Process Name:','Process','')"`) do set "procc=%%i"
echo %procc% > "%~dp0data\proc.txt"
goto stt


[
:inject

cls
setlocal

set "ordner=%~dp0data\dlls"
set "app=%~dp0data\temp\bin\xylo.exe"
set "arg_vor=--name %proc% --dll"
set "arg_nach=--inject"

if not exist "%ordner%" (
    mkdir %ordner% & goto inject
)

for %%F in ("%ordner%\*.*") do (
    "%app%" %arg_vor% "%%F" %arg_nach%
)
goto injectet
]
//
[
:adddlll

set "psCommand=Add-Type -AssemblyName System.Windows.Forms; $ofd = New-Object System.Windows.Forms.OpenFileDialog; $ofd.Filter='DLL files (*.dll)|*.dll'; $ofd.InitialDirectory=[Environment]::GetFolderPath('Desktop'); if ($ofd.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) { Write-Output $ofd.FileName }"
for /f "usebackq delims=" %%i in (`powershell -sta -command "%psCommand%"`) do (
    set "dllpath=%%i"
)
for %%F in ("%dllpath%") do set "dllname=%%~nF"
copy "%dllpath%" /ziel "%~dp0data\dlls\%dllname%.dll" /Y
goto stt
    {
        :removedll
        cls
        dir "%~dp0data\dlls" /B
        for /f "usebackq delims=" %%i in (`powershell -NoProfile -Command "[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic'); [Microsoft.VisualBasic.Interaction]::InputBox('enter Dll name:','Remove','')"`) do set "dname=%%i"
        if exist "%~dp0data\dlls\%dname%" del "%~dp0data\dlls\%dname%" /Q
        if exist "%~dp0data\dlls\%dname%.dll" del "%~dp0data\dlls\%dname%.dll" /Q
        goto stt
    }
]
[
    {
        :err001
        echo could not start %proc%
        goto end
    }
]
[
:makeall
echo Download
set "target=%~dp0data\src\get.bat"
mkdir "%~dp0data"
mkdir "%~dp0data\dlls" 
mkdir "%~dp0data\src"  
mkdir "%~dp0data\temp" 
mkdir "%~dp0data\temp\bin"
set "get=https://github.com/xqrto/pld/raw/main/get.bat"
curl -L -o "%target%" "%get%"
curl -L -o "%~dp0data\temp\GUI.html" "https://github.com/xqrto/pld/raw/main/GUI.html"
echo complete
goto stt
]
//
[
:abt
setlocal ENABLEDELAYEDEXPANSION
set "target=%~dp0data\src\abt.txt"
set "get=https://github.com/xqrto/pld/raw/main/abbout.txt"
curl -L -o "%target%" "%get%"
cls
color e
powershell -NoProfile -Command "Get-Content '%target%' | %% { $_.ToCharArray() | %% { Write-Host -NoNewline $_; Start-Sleep -Milliseconds 30 }; Write-Host '' }"
pause >NUL
goto stt
]
[
:injectet
set "AppName=%proc%" 
:loop
tasklist /FI "IMAGENAME eq %AppName%" 2>NUL | find /I "%AppName%" >NUL
if NOT errorlevel 1 (
    cls
    tasklist /v /fi "IMAGENAME eq %AppName%" 
    timeout /t 2 >nul
    goto loop
)
goto end
]
:end

del "%~dp0data\temp\bin\xylo.exe"
del "%~dp0data\src\path.var"

