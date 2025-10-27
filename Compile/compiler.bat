@echo off
if "%~1"=="" (
    echo Bitte compile oder decompile als erstes Argument angeben.
    exit /b
)
cd %~3
if /I "%~1"=="compile" goto compile
if /I "%~1"=="decompile" goto decompile

echo Ungueltiger Parameter: %1
exit /b

:compile
echo Starte enc.bat mit Parameter: "%~2"
call "%~dp0cp\enc.cmd" "%~2"
goto ende

:decompile
echo Starte dec.bat mit Parameter: "%~2"
call "%~dp0cp\dec.cmd" "%~2"
goto ende

:ende
echo Vorgang abgeschlossen.

