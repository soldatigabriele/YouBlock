@echo off

REM REM Check the script has been run as admin
REM net session >nul 2>&1
REM if NOT %errorLevel% == 0 (
REM     echo Script fallito: Clicca con il tasto destro ed Esegui come amministratore.
REM     PAUSE
REM     exit 0
REM )

rem set input = http://validatetoken.tk/validate?password=test_token
rem rem echo making the request?
rem curl -s -o /dev/null -i -w "%{http_code}" http://validatetoken.tk/validate?password=test_token
rem rem echo this is %response%


set site=www.validatetoken.tk/validate?password=solio_vide_il
set file=so.log
set code="%{http_code}\\n"
del /Q %file%
for /L %%r in (1,1,1) do curl -s -o %file% -I %site%
set match=false
echo %match%

for /f "usebackq delims=" %%a in (%file%) do (
	if "%%a"=="HTTP/1.1 403 Forbidden" (
		echo match found 1
		set match=true

	)
)

if %match%==true (
	echo "matching!"
)

pause


rem curl -s -o -i -w "%{http_code}" www.validatetoken.tk/validate?password=test_token >> %file%

rem For /F %%A In ('curl -s -o -i -w "%{http_code}" www.validatetoken.tk/validate?password=test_token') Do Set "test=%%~A"
rem If /I "%test%"=="failed" (
rem 	echo "failed"
rem ) else (
rem 	echo "%test%"
rem )

REM REM TODO check if it's "%~1" or %~1 without double quotes or %~1%
REM IF "%md5%"=="%~1" GOTO :password_corretta %~1
REM ECHO Password sbagliata
REM GOTO :end

REM :password_corretta
REM     ECHO Password corretta!
REM     if exist "C:\Windows\System32\drivers\etc\hosts_backup" (
REM         REM Remove the used password
REM         REM TODO check if it can override
REM         type C:\Windows\System32\drivers\etc\youblock_tokens | findstr /v "%~1" > C:\Windows\System32\drivers\etc\youblock_tokens
REM         REM Restore the hosts file
REM         copy "C:\Windows\System32\drivers\etc\hosts_backup" "C:\Windows\System32\drivers\etc\hosts">NUL
REM         del "C:\Windows\System32\drivers\etc\hosts_backup"
REM         ECHO Impostazioni ripristinate. Sei libero di guardare YouTube :D
REM     ) else (
REM         echo Hai gia' ripristinato le impostazioni. Riavvia il browser o il computer se non riesci ad accedere
REM     )

REM     if NOT exist "C:\Windows\System32\drivers\etc\hosts" (
REM         echo Gabriele ha fatto un danno. chiamalo se non riesci a vedere i siti bloccati dopo aver riavviato il computer
REM     )

REM :end

PAUSE
