@echo off
:: Stop any running instance of the payload
taskkill /f /im OneDrive.exe >nul 2>&1

:: Delete the payload from hidden directories
del /f /q "C:\ProgramData\OneDrive.exe" >nul 2>&1
rmdir /s /q "C:\ProgramData\HiddenSystemFiles" >nul 2>&1

:: Remove Scheduled Task
powershell -Command "Unregister-ScheduledTask -TaskName 'OneDriveUpdate' -Confirm:$false"

:: Restore Windows Defender settings
powershell -Command "Remove-MpPreference -ExclusionPath 'C:\ProgramData\OneDrive.exe'"
powershell -Command "Remove-MpPreference -ExclusionProcess 'C:\ProgramData\OneDrive.exe'"

:: Remove Registry Persistence (if added)
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveUpdate" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveUpdate" /f >nul 2>&1

:: Clear any leftover files
del /f /q "%~f0" >nul 2>&1
exit
