if not exist %~dp0data goto makeall
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
echo -----------------
echo -----------------
powershell -NoProfile -Command "$t='ID (%totl%)'; $t -split '`n' | ForEach-Object { $_.ToCharArray() | ForEach-Object { Write-Host -NoNewline $_; Start-Sleep -Milliseconds 30 }; Write-Host '' }"
cls 
echo -----------------
echo ID (%totl%)
echo ----------------
powershell -NoProfile -Command "$t='Made by xqrto'; $t -split '`n' | ForEach-Object { $_.ToCharArray() | ForEach-Object { Write-Host -NoNewline $_; Start-Sleep -Milliseconds 30 }; Write-Host '' }"
cls 
echo ----------------
echo ID (%totl%)
echo Made by xqrto
echo ----------------
powershell -NoProfile -Command "$t='powered by (xylo injector by xqrto)'; $t -split '`n' | ForEach-Object { $_.ToCharArray() | ForEach-Object { Write-Host -NoNewline $_; Start-Sleep -Milliseconds 30 }; Write-Host '' }"
cls
echo ----------------
echo ID (%totl%)
echo Made by xqrto
echo powered by (xylo injector by xqrto)
echo -----------------
echo Injector:
echo.
echo Process:
<nul set /p ="( "
powershell -NoProfile -Command "$t='%PRname%)'; $t -split '`n' | ForEach-Object { $_.ToCharArray() | ForEach-Object { Write-Host -NoNewline $_; Start-Sleep -Milliseconds 30 }; Write-Host '' }"
echo.
echo Dlls:
echo (
dir "%~dp0data\dlls" /B
echo )
echo.
echo Choose:
echo Inject        (1)
echo Process       (2)
echo.
echo Remove Dll    (3)
echo Add Dll       (4)
echo.
echo Abbout        (5)
echo -----------------

set /p menu=
if %menu%== 1 goto start
if %menu%== 2 goto mkproc
if %menu%== 3 goto removedll
if %menu%== 4 goto adddlll
if %menu%== 5 goto abt

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
set /p procc=
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
goto end
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
        set /p dname=
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
:end

del "%~dp0data\temp\bin\xylo.exe"
del "%~dp0data\src\path.var"

