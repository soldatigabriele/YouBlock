@echo off

rem Check the script has been run as admin
net session >nul 2>&1
if NOT %errorLevel% == 0 (
	echo Script fallito: Clicca con il tasto destro ed Esegui come amministratore.
	PAUSE
	exit 0
)

set /P password=  Password:
set site=www.validatetoken.tk/validate?password=
set file=so
set code="%{http_code}\\n"
for /L %%r in (1,1,1) do curl -s -o %file% -i %site%%password%
set match=false

for /f "usebackq delims=" %%a in (%file%) do (
	if "%%a"=="{"status":"ok","unlock":"valid"}" (
		set match=true
	)
)

IF %match%==true GOTO :password_corretta
	ECHO password sbagliata
GOTO :end

del /Q %file%

:password_corretta
    ECHO Password corretta!
    if exist "C:\Windows\System32\drivers\etc\hosts_backup" (
        rem Restore the hosts file
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
