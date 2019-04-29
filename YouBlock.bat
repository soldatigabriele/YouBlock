
@ECHO OFF

net session >nul 2>&1
if NOT %errorLevel% == 0 (
    echo Script fallito: Clicca con il tasto destro ed Esegui come amministratore.
    PAUSE
    exit 0
)

echo Sei sicuro di voler bloccare youtube? Per sbloccarlo avrai bisogno di una password!
set /P _confirm=  Per confermare scrivi "bloccalo" senza le virgolette: 

if "%_confirm%"=="bloccalo" GOTO :blocchiamolo:

echo Script annullato. Hai sbagliato a scrivere o hai annullato volutamente?
GOTO :end:

:blocchiamolo:
if NOT exist "C:\Windows\System32\drivers\etc\hosts_backup" (
	echo Blocchiamolo!
	copy "C:\Windows\System32\drivers\etc\hosts" "C:\Windows\System32\drivers\etc\hosts_backup" >NUL
	if NOT exist "C:\Windows\System32\drivers\etc\hosts_original" (
		copy "C:\Windows\System32\drivers\etc\hosts" "C:\Windows\System32\drivers\etc\hosts_original" >NUL
	)
	if exist "C:\Windows\System32\drivers\etc\hosts_backup" (
		echo Backup delle impostazioni originali eseguito con successo
		echo 127.0.0.1 youtube.com >> "C:\Windows\System32\Drivers\etc\hosts"
		echo 127.0.0.1 www.youtube.com >> "C:\Windows\System32\Drivers\etc\hosts"
		rem echo 127.0.0.1 facebook.com >> "C:\Windows\System32\Drivers\etc\hosts"
		rem echo 127.0.0.1 www.facebook.com >> "C:\Windows\System32\Drivers\etc\hosts"
		echo Blocco dei siti eseguito con successo. Riavvia il browser o il computer se i siti sono ancora accessibili
	)
) else (
	echo Script gia' eseguito. Non eseguire piu' volte
)


PAUSE

