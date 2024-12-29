
@echo off
if "%1"=="" (
    echo No PowerShell script specified.
    exit /b 1
)
call "C:\Program Files (x86)\Embarcadero\Studio\23.0\bin\rsvars.bat"
set PSScript=%1
shift
powershell -File "%PSScript%" %*
      