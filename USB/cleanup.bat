@echo off
:: Ensure admin privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -WindowStyle Hidden -Command "Start-Process cmd -ArgumentList '/c %~s0' -Verb RunAs"
    exit
)

:: Stop payload process
taskkill /f /im OneDrive.exe >nul 2>&1

:: Delete payload and task
del /f /q "C:\ProgramData\OneDrive.exe" >nul 2>&1
schtasks /delete /tn "OneDriveUpdate" /f >nul 2>&1

:: Remove Windows Defender exclusions
powershell -Command "Remove-MpPreference -ExclusionPath 'C:\ProgramData\OneDrive.exe'"
powershell -Command "Remove-MpPreference -ExclusionProcess 'C:\ProgramData\OneDrive.exe'"

:: Clear this script after execution
:: del /f /q "%~f0" >nul 2>&1
exit
