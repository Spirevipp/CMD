@echo off

echo This script let you automate pinging to update your arp table on your pc

set var1=1
set var2=1
set var3=1
set help=n
set /p help=Do you want an example? [y/n](default=n):

if %help% == y echo Choose a class
if %help% == y echo Class A = 10.0.0.0 Class B = 172.16.0.0 Class C = 192.168.1.0
if %help% == y echo Do not type the octets you want to search
if %help% == y echo Example: 
if %help% == y echo i choose B network with the ip 50.34.2.2
if %help% == y echo since i chose B, the program will scan the last two octets
if %help% == y echo in this case the last two are .2.2
if %help% == y echo so when the program asks for the ip i type in 50.34
if %help% == y echo then it asks for the range in the octets it should search
if %help% == y echo depending on the class you choose it will ask for the different octets
if %help% == y echo since i chose B it will first ask for the third, then the fourth
if %help% == y echo it wants a range from 0 to 255
if %help% == y echo it will go through the range for the last octet for each time it goes through the one before
if %help% == y echo this means if you type 230 on the last range
if %help% == y echo it will scan in this case 50.34.0.0-230
if %help% == y echo then 50.34.1.0-230 and so on until the third range is complete

if %help% == y pause

set class=C
set /p class=Type your ip class [A, B, C](default=C):
set ip=192.168.1
set /p ip=Type the ip network address, excluding the host octets (default=192.168.1):
set range3=255
if %class% == A set /p range3=Type the range you want to use for the second octet [0-255] (default=255):
set range2=255
if %class% == B set /p range2=Type the range you want to use for the third octet [0-255] (default=255):
set range1=255
set /p range1=Type the range you want to use for the last octet [0-255] (default=255):

:loop


if %class% == A ping %ip%.%var3%.%var2%.%var1% -n 1 -w 150

if %class% == B ping %ip%.%var2%.%var1% -n 1 -w 150

if %class% == C ping %ip%.%var1% -n 1 -w 150

if %var1% == %range1% set /A var2=var2+1
if %var2% == %range2% set /A var3=var3+1

set /A var1=var1+1

if %var1% LEQ %range1% goto loop
if %class% == C goto end

if %var2% LEQ %range2% set /A var1=0
if %var2% LEQ %range2% goto loop
if %class% == B goto end

if %var3% LEQ %range3% set /A var1=0
if %var3% LEQ %range3% set /A var2=0
if %var3% LEQ %range3% goto loop

:end
pause