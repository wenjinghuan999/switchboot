@echo off
setlocal enabledelayedexpansion

echo ========================================
echo  Systems avaliable:
echo ========================================
set idx=0
set CURRSYS=0
set systitle0=None bootable
for /f "tokens=1,2 delims=:" %%i in (systemlist.txt) do (
	set "flag= "
	set /a idx=!idx!+1
	set sysvar=sysid!idx!
	set !sysvar!=%%i
	set sysvar=systitle!idx!
	set !sysvar!=%%j
	set sysname=%%i
	set sysname=!sysname:~0,7!
	if exist %%i.txt (
		set "flag=*"
		set CURRSYS=!idx!
	)
	echo  !flag! [!idx!] %%j
	set "flag= "
	if !sysname! EQU WINDOWS (
		set /a idx=!idx!+1
		set sysvar=sysid!idx!
		set !sysvar!=%%iLegacy
		set sysvar=systitle!idx!
		set !sysvar!=%%j Legacy
		if exist %%iLegacy.txt (
			set "flag=*"
			set CURRSYS=!idx!
		)
		echo  !flag! [!idx!] %%j Legacy
	)
)
set "flag= "
if %CURRSYS% EQU 0 (
	set "flag=*"
)
echo ----------------------------------------
echo  %flag% [0] %systitle0%
echo ========================================

set n=%idx%
set systitle=!systitle%CURRSYS%!
echo Now using: [%CURRSYS%] %systitle%.
set sysdircurr=.

set TARGETSYS=-1
set /p TARGETSYS=Switch to: 
if %TARGETSYS% GEQ 0 (if %TARGETSYS% LEQ %n% (
	set systitle=!systitle%TARGETSYS%!
	if %TARGETSYS%==%CURRSYS% (
		echo Keeping: [%TARGETSYS%] !systitle!.
		goto :BYE
	) else (
		echo Switching to: [%TARGETSYS%] !systitle!...
		goto :SWTICHSYS
	)
) else (
	echo Cancelled.
	goto :BYE
)) else (
	echo Cancelled.
	goto :BYE
)

:SWTICHSYS
if %CURRSYS% EQU 0 (
	goto :SWTICHTARGET
)

set sysid=!sysid%CURRSYS%!
set sysdir=%sysid%
if %sysid:~-6%==Legacy (
	set sysdir=%sysid:~0,-6%
)
for /f "tokens=*" %%a in (%sysid%.txt) do (
	attrib -H %%a
	move %%a %sysdir%\%%a > nul
)

if %TARGETSYS% LEQ 0 (
	goto :DONE
)
set sysdircurr=%sysdir%

:SWTICHTARGET
if %TARGETSYS% LEQ 0 (
	goto :DONE
)

set sysid=!sysid%TARGETSYS%!
set sysdir=%sysid%
if %sysid:~-6%==Legacy (
	set sysdir=%sysid:~0,-6%
)

if %sysdircurr%==%sysdir% (
	ping -n 1 127.0.0.1 > nul
)

for /f "tokens=*" %%a in (%sysdir%\%sysid%.txt) do (
	move %sysdir%\%%a %%a > nul
	attrib +H %%a
)
	
:DONE
echo Done.

:BYE
pause
exit /B 0
