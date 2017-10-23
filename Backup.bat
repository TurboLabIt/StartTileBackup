@echo off

echo StartTileBackup
echo ----------------
echo A simple batch script to backup and restore the Start menu tiles and pinned apps.
echo.
echo Official project page: https://github.com/TurboLabIt/StartTileBackup
echo.
echo PRESS A KEY TO **BACKUP**!
pause


net session >nul 2>&1
if %errorLevel% == 0 (
        echo ### Running as administrator
    ) else (
		echo ### Permission denied! Please run this script as administrator
        GOTO END
    )

	
SET APPDIR=%~dp0
SET BACKUPDIR=%APPDIR%backup\
cd %APPDIR%
%~d0

IF NOT EXIST "%BACKUPDIR%" GOTO CREATE_BACKUP_DIR
echo ### Removing previous backup...
rmdir /s/q "%BACKUPDIR%"


:CREATE_BACKUP_DIR
echo ### Creating new backup dir in %BACKUPDIR%
mkdir "%BACKUPDIR%"


echo ### Killing File Explorer...
taskkill /im explorer.exe /f


echo ### File backup in progress!
robocopy "%LocalAppData%\Microsoft\Windows\CloudStore" "%BACKUPDIR%CloudStore" /E
robocopy "%LocalAppData%\Microsoft\Windows\Caches" "%BACKUPDIR%Caches" /E
robocopy "%LocalAppData%\Microsoft\Windows\Explorer" "%BACKUPDIR%Explorer" /E


echo ### Registry key backup in progress!
reg export HKCU\Software\Microsoft\Windows\CurrentVersion\CloudStore "%BACKUPDIR%CloudStore.reg"


echo ### Restarting File Explorer...
explorer.exe


:END
echo ### Procedure completed. Bye bye.
echo.
ping 127.0.0.1 -n 10 >NUL
