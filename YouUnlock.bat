@echo off & setlocal


net session >nul 2>&1
if NOT %errorLevel% == 0 (
    echo Script fallito: Clicca con il tasto destro ed Esegui come amministratore.
    PAUSE
    exit 0
)

set "plaintext=%~1"
set "file=%temp%\%~n0.tmp"
set md5=

if "%~1"=="/?" (
    echo Usage: %~nx0 file^|string
    echo    or: command ^| %~nx0
    echo;
    echo Example: set /P "=password" ^<NUL ^| %~nx0
    goto :EOF
)

if not defined plaintext set /P "plaintext= Password: 

if exist "%plaintext%" (
    set "file=%plaintext%"
) else for %%I in ("%file%") do if %%~zI equ 0 (
    <NUL >"%file%" set /P "=%plaintext%"
)

for /f "skip=1 delims=" %%I in ('certutil -hashfile "%file%" MD5') do (
    if not defined md5 set "md5=%%I"
)

2>NUL del "%temp%\%~n0.tmp"

IF "%md5%"=="edcd954a4ea3acceb3ccbe19dfb0bbf1" GOTO :password_corretta:

ECHO Password sbagliata
GOTO :end:

:password_corretta:
ECHO Password corretta!
if exist "C:\Windows\System32\drivers\etc\hosts_backup" (
    copy "C:\Windows\System32\drivers\etc\hosts_backup" "C:\Windows\System32\drivers\etc\hosts">NUL
    del "C:\Windows\System32\drivers\etc\hosts_backup"
    ECHO Impostazioni ripristinate. Sei libero di guardare YouTube :D
) else (
    echo Hai gia' ripristinato le impostazioni. Riavvia il browser o il computer se non riesci ad accedere
)

if NOT exist "C:\Windows\System32\drivers\etc\hosts" (
	echo Gabriele ha fatto un danno. chiamalo se non riesci a vedere i siti bloccati dopo aver riavviato il computer
)

:end:

PAUSE




