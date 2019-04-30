@echo off & setlocal


REM Check the script has been run as admin
net session >nul 2>&1
if NOT %errorLevel% == 0 (
    echo Script fallito: Clicca con il tasto destro ed Esegui come amministratore.
    PAUSE
    exit 0
)

REM MD5 Checker
set "plaintext=%~1"
set "file=%temp%\%~n0.tmp"
set md5=
set /P "plaintext= Password: "
if exist "%plaintext%" (
    set "file=%plaintext%"
)
for /f "skip=1 delims=" %%I in ('certutil -hashfile "%file%" MD5') do (
    if not defined md5 set "md5=%%I"
)
2>NUL del "%temp%\%~n0.tmp"

REM Check every token in the file
for /f %%i in ("C:\Windows\System32\drivers\etc\youblock_tokens") do set size=%%~zi
if %size% gtr 0 (
    FOR /F %%i IN ("C:\Windows\System32\drivers\etc\youblock_tokens") DO :check_password %%i
) else (
    echo Hai finito le possibilita'. Per resettare le password esegui ResetPasswords.bat come amministratore. Se vuoi nuove password, contatta Gabriele.
)

:check_password
    REM TODO check if it's "%~1" or %~1 without double quotes or %~1%
    IF "%md5%"=="%~1" GOTO :password_corretta %~1
    ECHO Password sbagliata
    GOTO :end
:end

:password_corretta
    ECHO Password corretta!
    if exist "C:\Windows\System32\drivers\etc\hosts_backup" (
        REM Remove the used password
        REM TODO check if it can override
        type C:\Windows\System32\drivers\etc\youblock_tokens | findstr /v "%~1" > C:\Windows\System32\drivers\etc\youblock_tokens
        REM Restore the hosts file
        copy "C:\Windows\System32\drivers\etc\hosts_backup" "C:\Windows\System32\drivers\etc\hosts">NUL
        del "C:\Windows\System32\drivers\etc\hosts_backup"
        ECHO Impostazioni ripristinate. Sei libero di guardare YouTube :D
    ) else (
        echo Hai gia' ripristinato le impostazioni. Riavvia il browser o il computer se non riesci ad accedere
    )

    if NOT exist "C:\Windows\System32\drivers\etc\hosts" (
        echo Gabriele ha fatto un danno. chiamalo se non riesci a vedere i siti bloccati dopo aver riavviato il computer
    )

:end

PAUSE




