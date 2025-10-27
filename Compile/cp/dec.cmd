@echo off & setlocal
if "%~1"=="" exit /b
if /i "%~x1" neq ".bat" if /i "%~x1" neq ".cmd" exit /b
<"%~1" ((for /l %%N in (1 1 8) do pause)>nul&findstr "^">"%~n1__%~x1")
