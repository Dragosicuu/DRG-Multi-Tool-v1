cls
@echo off
title Dragosicu Multi-Tool v1
chcp 65001 >nul

setlocal enabledelayedexpansion
rem
for /f %%i in ('echo %USERNAME%') do set "user=%%i"

goto menu
:menu
echo.
echo.
echo.
echo                          [38;2;0;0;255m██████╗ ██████╗  █████╗  ██████╗  ██████╗ ███████╗██╗ ██████╗██╗   ██╗[0m
echo                          [38;2;51;51;255m██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔═══██╗██╔════╝██║██╔════╝██║   ██║[0m
echo                          [38;2;102;102;255m██║  ██║██████╔╝███████║██║  ███╗██║   ██║███████╗██║██║     ██║   ██║[0m
echo                          [38;2;153;153;255m██║  ██║██╔══██╗██╔══██║██║   ██║██║   ██║╚════██║██║██║     ██║   ██║[0m 
echo                          [38;2;204;204;255m██████╔╝██║  ██║██║  ██║╚██████╔╝╚██████╔╝███████║██║╚██████╗╚██████╔[0m 
echo                          ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝╚═╝ ╚═════╝ ╚═════╝     
echo                                                    Multi-Tool v1
echo.
echo.
echo           ┍━━━━━━━━━━━━━━━━━━━━━━━━━━┑     ┍━━━━━━━━━━━━━━━━━━━━━━━━━━┑      ┍━━━━━━━━━━━━━━━━━━━━━━━━━━┑           
echo           │ 1.  Nslookup             │     │ 6.  Password Generator   │      │ 11. Visa Card Generator  │ 
echo           │ 2.  Ping                 │     │ 7.  PIN Generator        │      │ 12. Mastercard Generator │
echo           │ 3.  Tracert              │     │ 8.  Temp Mail Generator  │      │ 13. AMEX Card Generator  │
echo           │ 4.  Whois                │     │ 9.  IPv4 Generator       │      │ 14. JCB Card Generator   │
echo           │ 5.  Ip Geolocation       │     │ 10. IPv6 Generator       │      │ 15. UnionPay Generator   │
echo           ┕━━━━━━━━━━━━━━━━━━━━━━━━━━┙     ┕━━━━━━━━━━━━━━━━━━━━━━━━━━┙      ┕━━━━━━━━━━━━━━━━━━━━━━━━━━┙
echo.
echo                                                   0. Credits
echo.
echo ┌──(!user!@DRG-Multitool-V1)
set /p "choice=└─# "
echo.

if "%choice%"=="1" goto nslookup
if "%choice%"=="2" goto ping
if "%choice%"=="3" goto tracert
if "%choice%"=="4" goto whois
if "%choice%"=="5" goto ipgeo
if "%choice%"=="6" goto passgen
if "%choice%"=="7" goto pingen
if "%choice%"=="8" goto tempmailgen
if "%choice%"=="9" goto ipv4gen
if "%choice%"=="10" goto ipv6gen
if "%choice%"=="11" goto visacardgen
if "%choice%"=="12" goto mastercardgen
if "%choice%"=="13" goto amexgen 
if "%choice%"=="14" goto jcbgen
if "%choice%"=="15" goto unionpaygen
if "%choice%"=="0" goto credits


:nslookup
set /p target= Nslookup - Enter domain or IP:
nslookup %target%
pause
cls
goto menu

:ping
set /p target= Ping - Enter domain or IP (Press CTRL + C to stop): 
ping -t %target% 
pause
cls
goto menu

:tracert
set /p target= Tracert - Enter domain or IP:
tracert %target%
pause
cls
goto menu

:passgen
setlocal EnableDelayedExpansion

set /p length=Password length (ex: 12): 
if not defined length set length=12

set "charset=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+"
set "password="

for /L %%i in (1,1,%length%) do (
    set /a rnd=!random! %% 76
    call set "char=%%charset:~!rnd!,1%%"
    set "password=!password!!char!"
)

echo.
echo Generated password: !password!
echo.
pause
cls
goto menu

:whois
set /p target= Whois - Enter domain or IP:
start https://www.who.is/whois/%target%
pause
cls
goto menu

:ipgeo
set /p ip= Enter IP or domain: 

curl -s http://ip-api.com/json/%ip% > ipgeo_raw.txt

(
    findstr /i "query country regionName city isp org as" ipgeo_raw.txt
) > "ipgeolocation output.txt"

del ipgeo_raw.txt

echo Saved in "ipgeolocation output.txt"
pause
cls
goto menu


:pingen
setlocal EnableDelayedExpansion

set /p length=Password length (ex: 4): 
if not defined length set length=4

set "charset=0123456789"
set "password="

for /L %%i in (1,1,%length%) do (
    set /a rnd=!random! %% 10
    call set "char=%%charset:~!rnd!,1%%"
    set "password=!password!!char!"
)

echo.
echo Generated PIN: !password!
echo.
pause
cls
goto menu


:visacardgen
setlocal enabledelayedexpansion

set "data_folder=Card generator output"

if not exist "%data_folder%" (
    mkdir "%data_folder%"
)

set /p num_cards=How many visa cards do you want to generate? 

if not exist "%data_folder%\generator_first_names.txt" (
    echo The file generator_first_names.txt is missing in "%data_folder%".
    pause
    cls
    goto menu
)

if not exist "%data_folder%\generator_last_names.txt" (
    echo The file generator_last_names.txt is missing in "%data_folder%".
    pause
    cls
    goto menu
)

for /f %%A in ('find /c /v "" ^< "%data_folder%\generator_first_names.txt"') do set first_count=%%A
for /f %%A in ('find /c /v "" ^< "%data_folder%\generator_last_names.txt"') do set last_count=%%A

> "%data_folder%\visa_generated_cards" echo --- VISA CARD GENERATED DATA ---

for /L %%i in (1,1,%num_cards%) do (
    set /a rand_first=!random! %% %first_count% + 1
    set /a rand_last=!random! %% %last_count% + 1

    set count=0
    for /f "usebackq delims=" %%F in ("%data_folder%\generator_first_names.txt") do (
        set /a count+=1
        if !count! EQU !rand_first! set "first_name=%%F"
    )

    set count=0
    for /f "usebackq delims=" %%L in ("%data_folder%\generator_last_names.txt") do (
        set /a count+=1
        if !count! EQU !rand_last! set "last_name=%%L"
    )

    call :GenCardNumber card_number
    call :GenCVV cvv
    call :GenPIN pin
    call :GenExpiry expiry

    >> "%data_folder%\visa_generated_cards" echo Name: !first_name! !last_name!
    >> "%data_folder%\visa_generated_cards" echo Card Number: !card_number!
    >> "%data_folder%\visa_generated_cards" echo Expiry Date: !expiry!
    >> "%data_folder%\visa_generated_cards" echo CVV: !cvv!
    >> "%data_folder%\visa_generated_cards" echo PIN: !pin!
    >> "%data_folder%\visa_generated_cards" echo -------------------------------------
)

echo Your visa card/s were generated in: "%data_folder%\visa_generated_cards"
pause
cls
goto menu

:GenCardNumber
set "digits="
for /L %%a in (1,1,16) do (
    set /a digit=!random! %% 10
    set "digits=!digits!!digit!"
)
set "%~1=%digits%"
goto :eof

:GenCVV
set /a cvv=!random! %% 900 + 100
set "%~1=%cvv%"
goto :eof

:GenPIN
set /a pin=!random! %% 9000 + 1000
set "%~1=%pin%"
goto :eof

:GenExpiry
set /a month=!random! %% 12 + 1
if !month! LSS 10 set "month=0!month!"
set /a year=!random! %% 5 + 26
set "%~1=!month!/!year!"
goto :eof



:mastercardgen
setlocal enabledelayedexpansion

set "data_folder=Card generator output"

if not exist "%data_folder%" (
    mkdir "%data_folder%"
)

set /p num_cards=How many Mastercard cards do you want to generate? 

if not exist "%data_folder%\generator_first_names.txt" (
    echo The file generator_first_names.txt is missing in "%data_folder%".
    pause
    cls
    goto menu
)

if not exist "%data_folder%\generator_last_names.txt" (
    echo The file generator_last_names.txt is missing in "%data_folder%".
    pause
    cls
    goto menu
)

for /f %%A in ('find /c /v "" ^< "%data_folder%\generator_first_names.txt"') do set first_count=%%A
for /f %%A in ('find /c /v "" ^< "%data_folder%\generator_last_names.txt"') do set last_count=%%A

> "%data_folder%\mastercard_generated_cards" echo --- MASTERCARD GENERATED DATA ---

for /L %%i in (1,1,%num_cards%) do (
    set /a rand_first=!random! %% %first_count% + 1
    set /a rand_last=!random! %% %last_count% + 1

    set count=0
    for /f "usebackq delims=" %%F in ("%data_folder%\generator_first_names.txt") do (
        set /a count+=1
        if !count! EQU !rand_first! set "first_name=%%F"
    )

    set count=0
    for /f "usebackq delims=" %%L in ("%data_folder%\generator_last_names.txt") do (
        set /a count+=1
        if !count! EQU !rand_last! set "last_name=%%L"
    )

    call :GenMasterCardNumber card_number
    call :GenCVV cvv
    call :GenPIN pin
    call :GenExpiry expiry

    >> "%data_folder%\mastercard_generated_cards" echo Name: !first_name! !last_name!
    >> "%data_folder%\mastercard_generated_cards" echo Card Number: !card_number!
    >> "%data_folder%\mastercard_generated_cards" echo Expiry Date: !expiry!
    >> "%data_folder%\mastercard_generated_cards" echo CVV: !cvv!
    >> "%data_folder%\mastercard_generated_cards" echo PIN: !pin!
    >> "%data_folder%\mastercard_generated_cards" echo -------------------------------------
)

echo Your Mastercard/s were generated in: "%data_folder%\mastercard_generated_cards"
pause
cls
goto menu

:GenMasterCardNumber
set /a prefix=51 + !random! %% 5
set "digits=%prefix%"
for /L %%a in (1,1,14) do (
    set /a digit=!random! %% 10
    set "digits=!digits!!digit!"
)
set "%~1=%digits%"
goto :eof

:GenCVV
set /a cvv=!random! %% 900 + 100
set "%~1=%cvv%"
goto :eof

:GenPIN
set /a pin=!random! %% 9000 + 1000
set "%~1=%pin%"
goto :eof

:GenExpiry
set /a month=!random! %% 12 + 1
if !month! LSS 10 set "month=0!month!"
set /a year=!random! %% 5 + 26
set "%~1=!month!/!year!"
goto :eof


:amexgen
setlocal enabledelayedexpansion

set "data_folder=Card generator output"

if not exist "%data_folder%" (
    mkdir "%data_folder%"
)

set /p num_cards=How many American Express cards do you want to generate? 

if not exist "%data_folder%\generator_first_names.txt" (
    echo The file generator_first_names.txt is missing in "%data_folder%".
    pause
    cls
    goto menu
)

if not exist "%data_folder%\generator_last_names.txt" (
    echo The file generator_last_names.txt is missing in "%data_folder%".
    pause
    cls
    goto menu
)

for /f %%A in ('find /c /v "" ^< "%data_folder%\generator_first_names.txt"') do set first_count=%%A
for /f %%A in ('find /c /v "" ^< "%data_folder%\generator_last_names.txt"') do set last_count=%%A

> "%data_folder%\amex_generated_cards" echo --- AMERICAN EXPRESS GENERATED DATA ---

for /L %%i in (1,1,%num_cards%) do (
    set /a rand_first=!random! %% %first_count% + 1
    set /a rand_last=!random! %% %last_count% + 1

    set count=0
    for /f "usebackq delims=" %%F in ("%data_folder%\generator_first_names.txt") do (
        set /a count+=1
        if !count! EQU !rand_first! set "first_name=%%F"
    )

    set count=0
    for /f "usebackq delims=" %%L in ("%data_folder%\generator_last_names.txt") do (
        set /a count+=1
        if !count! EQU !rand_last! set "last_name=%%L"
    )

    call :GenAmexCardNumber card_number
    call :GenAmexCVV cvv
    call :GenPIN pin
    call :GenExpiry expiry

    >> "%data_folder%\amex_generated_cards" echo Name: !first_name! !last_name!
    >> "%data_folder%\amex_generated_cards" echo Card Number: !card_number!
    >> "%data_folder%\amex_generated_cards" echo Expiry Date: !expiry!
    >> "%data_folder%\amex_generated_cards" echo CVV: !cvv!
    >> "%data_folder%\amex_generated_cards" echo PIN: !pin!
    >> "%data_folder%\amex_generated_cards" echo -------------------------------------
)

echo Your American Express card/s were generated in: "%data_folder%\amex_generated_cards"
pause
cls
goto menu

:GenAmexCardNumber
set /a prefix=34 + (!random! %% 2)*3
set "digits=%prefix%"
for /L %%a in (1,1,13) do (
    set /a digit=!random! %% 10
    set "digits=!digits!!digit!"
)
set "%~1=%digits%"
goto :eof

:GenAmexCVV
set /a cvv=!random! %% 9000 + 1000
set "%~1=%cvv%"
goto :eof

:GenPIN
set /a pin=!random! %% 9000 + 1000
set "%~1=%pin%"
goto :eof

:GenExpiry
set /a month=!random! %% 12 + 1
if !month! LSS 10 set "month=0!month!"
set /a year=!random! %% 5 + 26
set "%~1=!month!/!year!"
goto :eof

    set /a digit=!random! %% 10
    set "digits=!digits!!digit!"
)
set "%~1=%digits%"
goto :eof

:genamexccv
set /a cvv=!random! %% 9000 + 1000
set "%~1=%cvv%"
goto :eof

:genpin
set /a pin=!random! %% 9000 + 1000
set "%~1=%pin%"
goto :eof

:genexpiry
set /a month=!random! %% 12 + 1
if !month! LSS 10 set "month=0!month!"
set /a year=!random! %% 5 + 26
set "%~1=!month!/!year!"
goto :eof


:jcbgen
setlocal enabledelayedexpansion

set "data_folder=Card generator output"

if not exist "%data_folder%" (
    mkdir "%data_folder%"
)

set /p num_cards=How many JCB cards do you want to generate? 

if not exist "%data_folder%\generator_first_names.txt" (
    echo The file generator_first_names.txt is missing in "%data_folder%".
    pause
    exit /b
)

if not exist "%data_folder%\generator_last_names.txt" (
    echo The file generator_last_names.txt is missing in "%data_folder%".
    pause
    exit /b
)

for /f %%A in ('find /c /v "" ^< "%data_folder%\generator_first_names.txt"') do set first_count=%%A
for /f %%A in ('find /c /v "" ^< "%data_folder%\generator_last_names.txt"') do set last_count=%%A

> "%data_folder%\jcb_generated_cards" echo --- JCB GENERATED DATA ---

for /L %%i in (1,1,%num_cards%) do (
    set /a rand_first=!random! %% %first_count% + 1
    set /a rand_last=!random! %% %last_count% + 1

    set count=0
    for /f "usebackq delims=" %%F in ("%data_folder%\generator_first_names.txt") do (
        set /a count+=1
        if !count! EQU !rand_first! set "first_name=%%F"
    )

    set count=0
    for /f "usebackq delims=" %%L in ("%data_folder%\generator_last_names.txt") do (
        set /a count+=1
        if !count! EQU !rand_last! set "last_name=%%L"
    )

    call :GenJCBNumber card_number
    call :GenCVV cvv
    call :GenPIN pin
    call :GenExpiry expiry

    >> "%data_folder%\jcb_generated_cards" echo Name: !first_name! !last_name!
    >> "%data_folder%\jcb_generated_cards" echo Card Number: !card_number!
    >> "%data_folder%\jcb_generated_cards" echo Expiry Date: !expiry!
    >> "%data_folder%\jcb_generated_cards" echo CVV: !cvv!
    >> "%data_folder%\jcb_generated_cards" echo PIN: !pin!
    >> "%data_folder%\jcb_generated_cards" echo -------------------------------------
)

echo Your JCB card/s were generated in: "%data_folder%\jcb_generated_cards"
pause
exit /b

:GenJCBNumber
set /a prefix=3528 + !random! %% 62
set "digits=%prefix%"
for /L %%a in (1,1,12) do (
    set /a digit=!random! %% 10
    set "digits=!digits!!digit!"
)
set "%~1=%digits%"
goto :eof

:GenCVV
set /a cvv=!random! %% 900 + 100
set "%~1=%cvv%"
goto :eof

:GenPIN
set /a pin=!random! %% 9000 + 1000
set "%~1=%pin%"
goto :eof

:GenExpiry
set /a month=!random! %% 12 + 1
if !month! LSS 10 set "month=0!month!"
set /a year=!random! %% 5 + 26
set "%~1=!month!/!year!"
goto :eof


:unionpaygen
setlocal enabledelayedexpansion

set "data_folder=Card generator output"

if not exist "%data_folder%" (
    mkdir "%data_folder%"
)

set /p num_cards=How many UnionPay cards do you want to generate? 

if not exist "%data_folder%\generator_first_names.txt" (
    echo The file generator_first_names.txt is missing in "%data_folder%".
    pause
    exit /b
)

if not exist "%data_folder%\generator_last_names.txt" (
    echo The file generator_last_names.txt is missing in "%data_folder%".
    pause
    exit /b
)

for /f %%A in ('find /c /v "" ^< "%data_folder%\generator_first_names.txt"') do set first_count=%%A
for /f %%A in ('find /c /v "" ^< "%data_folder%\generator_last_names.txt"') do set last_count=%%A

> "%data_folder%\unionpay_generated_cards" echo --- UNIONPAY GENERATED DATA ---

for /L %%i in (1,1,%num_cards%) do (
    set /a rand_first=!random! %% %first_count% + 1
    set /a rand_last=!random! %% %last_count% + 1

    set count=0
    for /f "usebackq delims=" %%F in ("%data_folder%\generator_first_names.txt") do (
        set /a count+=1
        if !count! EQU !rand_first! set "first_name=%%F"
    )

    set count=0
    for /f "usebackq delims=" %%L in ("%data_folder%\generator_last_names.txt") do (
        set /a count+=1
        if !count! EQU !rand_last! set "last_name=%%L"
    )

    call :GenUnionPayNumber card_number
    call :GenCVV cvv
    call :GenPIN pin
    call :GenExpiry expiry

    >> "%data_folder%\unionpay_generated_cards" echo Name: !first_name! !last_name!
    >> "%data_folder%\unionpay_generated_cards" echo Card Number: !card_number!
    >> "%data_folder%\unionpay_generated_cards" echo Expiry Date: !expiry!
    >> "%data_folder%\unionpay_generated_cards" echo CVV: !cvv!
    >> "%data_folder%\unionpay_generated_cards" echo PIN: !pin!
    >> "%data_folder%\unionpay_generated_cards" echo -------------------------------------
)

echo Your UnionPay card/s were generated in: "%data_folder%\unionpay_generated_cards"
pause
exit /b

:GenUnionPayNumber
set "digits=62"
for /L %%a in (1,1,14) do (
    set /a digit=!random! %% 10
    set "digits=!digits!!digit!"
)
set "%~1=%digits%"
goto :eof

:GenCVV
set /a cvv=!random! %% 900 + 100
set "%~1=%cvv%"
goto :eof

:GenPIN
set /a pin=!random! %% 9000 + 1000
set "%~1=%pin%"
goto :eof

:GenExpiry
set /a month=!random! %% 12 + 1
if !month! LSS 10 set "month=0!month!"
set /a year=!random! %% 5 + 26
set "%~1=!month!/!year!"
goto :eof

:tempmailgen
setlocal enabledelayedexpansion

set /p count=How many temp mails do you wanna generate? 

if not exist "Email Generator Output" mkdir "Email Generator Output"
set "output=Email Generator Output\email_address_generator.txt"
> "%output%" echo List of generated temporary emails:

set "chars=abcdefghijklmnopqrstuvwxyz0123456789"

for /L %%i in (1,1,%count%) do (
    setlocal enabledelayedexpansion
    set "user="

    for /L %%j in (1,1,10) do (
        set /a index=!random! %% 36
        call set "char=%%chars:~!index!,1%%%"
        set "user=!user!!char!"
    )

    set "email=!user!@mail.tm"
    set "pass=!user!pass"

    (
        echo {
        echo   "address": "!email!",
        echo   "password": "!pass!"
        echo }
    ) > request.json

    curl -s -X POST https://api.mail.tm/accounts ^
        -H "Content-Type: application/json" ^
        -d @request.json > nul

    echo !email!
    echo !email!>> "%output%"
    del request.json
    endlocal
)

echo.
echo Your temp mail(s) have been saved to "%output%"
pause

:ipv4gen
setlocal enabledelayedexpansion

set /p ipCount= How many IPv4 address(es) do you wanna generate? 

> ipv4_generator_output (

for /l %%i in (1,1,%ipCount%) do (
    set /a "oct1=!random! %% 256"
    set /a "oct2=!random! %% 256"
    set /a "oct3=!random! %% 256"
    set /a "oct4=!random! %% 256"
    echo !oct1!.!oct2!.!oct3!.!oct4!
)

) >> ipv4_generator_output.txt

echo Your IPv4 address(es) saved in: ipv4_generator_output.txt
pause
cls
goto menu

:ipv6gen
@echo off
setlocal enabledelayedexpansion

set /p ipCount= How many IPv6 addresses do you want to generate? 

> ipv6_generator_output.txt (
    for /L %%i in (1,1,%ipCount%) do (
        set "ip="
        set "hasLetter=false"
        
        for /L %%j in (1,1,8) do (
            set "block="
            for /L %%k in (1,1,4) do (
                set /a rnd=!random! %% 16
                set "hex="
                if !rnd! LSS 10 (
                    set "hex=!rnd!"
                ) else (
                    set /a letterIndex=!rnd! - 10
                    for %%c in (a b c d e f) do (
                        if !letterIndex! EQU 0 (
                            set "hex=%%c"
                            set "hasLetter=true"
                        )
                        set /a letterIndex-=1
                    )
                )
                set "block=!block!!hex!"
            )
            set "ip=!ip!!block!:"
        )

        rem Remove last colon
        set "ip=!ip:~0,-1!"

        rem
        if "!hasLetter!"=="false" (
            set /a rndBlock=!random! %% 8 + 1
            set "block="
            for /L %%k in (1,1,4) do (
                set /a rnd=!random! %% 6
                for %%c in (a b c d e f) do (
                    if !rnd! EQU 0 (
                        set "hex=%%c"
                    )
                    set /a rnd-=1
                )
                set "block=!block!!hex!"
            )
            call set "ip=%%ip:~0,!(rndBlock!-1)*5!%%!block!%%ip:~!(rndBlock!*5)!%%"
        )

        echo !ip!
    )
)

echo Your IPv6 address(es) saved to: ipv6_generator_output.txt
pause

:credits
cls
echo.
echo.
echo.
echo                                  [38;2;0;0;255m ██████╗██████╗ ███████╗██████╗ ██╗████████╗███████╗[0m
echo                                  [38;2;51;51;255m██╔════╝██╔══██╗██╔════╝██╔══██╗██║╚══██╔══╝██╔════╝[0m
echo                                  [38;2;102;102;255m██║     ██████╔╝█████╗  ██║  ██║██║   ██║   ███████╗[0m
echo                                  [38;2;204;204;255m██║     ██╔══██╗██╔══╝  ██║  ██║██║   ██║   ╚════██║[0m
echo                                  ╚██████╗██║  ██║███████╗██████╔╝██║   ██║   ███████║
echo                                   ╚═════╝╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝   ╚═╝   ╚══════╝
echo.
echo                                                 Coded by: Dragosicu   
echo                                            Early Supporters: Arko, Dillon
echo.
echo.
echo.
pause
cls
goto menu
                                         