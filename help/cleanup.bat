@echo off
echo [*] در حال حذف پایداری و نابودی پیلود...

:: متوقف کردن فرآیند پیلود
taskkill /IM updater.exe /F

:: حذف از رجیستری (Startup)
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v Updater /f

:: حذف Scheduled Task
schtasks /delete /tn "WindowsUpdater" /f

:: حذف فایل پیلود
del /F /Q "C:\Users\Public\updater.exe"

:: حذف خود اسکریپت پس از اجرا
del /F /Q "%~f0"

echo [*] عملیات پاکسازی کامل شد!
exit
