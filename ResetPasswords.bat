@ECHO off & setlocal

REM Check the script has been run as admin
net session >nul 2>&1
if NOT %errorLevel% == 0 (
    ECHO Script fallito: Clicca con il tasto destro ed Esegui come amministratore.
    PAUSE
    exit 0
)

echo Sei sicuro di voler resettare le password?
set /P _confirm=  Per confermare scrivi "reset" senza le virgolette: 

if "%_confirm%"=="reset" GOTO :reset

:reset
    del "C:\Windows\System32\drivers\etc\youblock_tokens" >NUL
	if exist "%~dp0%\bin" (
        copy "%~dp0%\bin" "C:\Windows\System32\drivers\etc\youblock_tokens" >NUL
    ) else (
        echo Controlla che il file "bin" esista nella cartella corrente
    )
:end

PAUSE
