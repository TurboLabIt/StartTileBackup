@echo off

echo StartTileBackup
echo ----------------
echo A simple batch script to backup and restore the Start menu tiles and pinned apps.
echo.
echo Official project page: https://github.com/TurboLabIt/StartTileBackup
echo.
echo PRESS A KEY TO **RESTORE**!
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

IF NOT EXIST "%BACKUPDIR%" (
		
		echo ### BACKUP DIRECTORY NOT FOUND!
		echo ### Please run Backup.bat first to create a backup
		GOTO END
	)


echo ### Killing File Explorer...
taskkill /im explorer.exe /f


echo ### File restore in progress!
rmdir /s/q "%LocalAppData%\Microsoft\Windows\CloudStore"
robocopy "%BACKUPDIR%CloudStore" "%LocalAppData%\Microsoft\Windows\CloudStore" /E

rmdir /s/q "%LocalAppData%\Microsoft\Windows\Caches"
robocopy "%BACKUPDIR%Caches" "%LocalAppData%\Microsoft\Windows\Caches" /E

rmdir /s/q "%LocalAppData%\Microsoft\Windows\Explorer"
robocopy "%BACKUPDIR%Explorer" "%LocalAppData%\Microsoft\Windows\Explorer" /E


echo ### Registry key restore in progress!
reg import "%BACKUPDIR%CloudStore.reg"


echo ### Restarting File Explorer...
explorer.exe


:END
echo ### Procedure completed. Bye bye.
echo.
ping 127.0.0.1 -n 10 >NUL
