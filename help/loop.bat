@echo off
set payloadPath=C:\Users\Public\updater.exe

:loop
timeout /t 30 /nobreak
tasklist | find /i "updater.exe" >nul || start "" /B "%payloadPath%"
goto loop
