@echo off
setlocal
cd %~dp0
SET windowTitle=Paradox's Mod Builder:
TITLE %windowTitle% Getting Ready...

REM ****************************** CONFIGURATION - DO NOT EDIT ANYTHING OUTSIDE THIS SECTION ******************************

:: GTA San Andreas Install Path (e.g: C:\Games\GTA Trilogy\GTA San Andreas - Definitive Edition). Not required if autoinstall = false.
SET installdir=

:: Mod Staging Directory. This is where your mod files reside. You can leave it as is.
SET stagingdir=%~dp0staging

:: Mod PAK Name. A higher number means higher priority over other mods. You can leave it as is.
SET pakname=999-CustomModSA_P

:: Skip Compiling Scripts. Set to true to skip compiling game scripts and build the PAK file with the staging data as-is.
SET skipcompile=true

:: Skip PAK Building. Set to true to skip packing the mod into a PAK.
SET skippak=false

:: Auto-Install Mod. Automatically copies the mod to your game install directory after building if set to true.
SET autoinstall=true

REM ******************************************** END OF CONFIGURATION SECTION *********************************************

SET originaldata=%stagingdir%\Gameface\Content\OriginalData
SET moddir=%installdir%\Gameface\Content\Paks\~Mods

goto initcheck

:ascii
cls
echo.
echo                     Art's not here, maaaannn...
echo.
echo     --------------------------------------------------------
echo              Paradox's GTA SA Definitive Mod Builder
echo        Github: github.com/maega ^| Twitter: @ParadoxEpoch
echo     --------------------------------------------------------
echo.
exit /B 0

:initcheck
call :ascii

echo Game Install Path: %installdir%
echo Mod Staging Path: %stagingdir%
echo.

if "%installdir%" == "" if "%autoinstall%" == "true" goto errdirconfig
if not exist "%installdir%\" if "%autoinstall%" == "true" goto errdirconfig
if not exist "%moddir%\" if "%autoinstall%" == "true" mkdir "%moddir%"
if not exist "%originaldata%\GTASA\data\sc.exe" if not "%skipcompile%" == "true" goto errnocompiler
if not exist "%originaldata%\GTASA\Scripts\main.sc" if not "%skipcompile%" == "true" goto errnoscript

echo *** Tasks: ***
if not "%skipcompile%" == "true" echo - Compile Game Scripts
if not "%skippak%" == "true" echo - Build mod into Unreal Engine PAK
if "%autoinstall%" == "true" echo - Install mod into game installation folder
echo.

echo If this all looks good, press any key to begin...
pause>nul

REM **************************************************************************
REM **************************  COMPILE SCRIPTS  *****************************
REM **************************************************************************

:compile
if "%skipcompile%" == "true" goto buildpak
call :ascii
echo Compiling game scripts is currently not supported for San Andreas.
echo This is due to some missing files that the SA Script Compiler needs.
echo Check the README for more information
echo.
pause
goto buildpak
TITLE %windowTitle% Compiling Game Scripts...
echo Compiling GTA San Andreas Game Scripts...
cd %originaldata%\GTASA\data
sc.exe -cmdlist -missionout -san_andreas_pc -f ..\Scripts\mainV1.sc -close
if ERRORLEVEL 1 goto errcompile
xcopy /Y /D ..\Scripts\mainV1.scm .\script\
echo Cleaning up staging directory...
del LogFile.txt full_script_text.txt
cd ..\Scripts
del alpha_text.txt command_usage.txt main.scm main_text.txt missiontextkeys.txt
del ordered_commands.txt variable_info.txt variable_usage.txt GTASASaveInfo.dat
cd %~dp0

REM **************************************************************************
REM *****************************  BUILD PAK  ********************************
REM **************************************************************************

:buildpak
if "%skippak%" == "true" goto installpak
call :ascii
TITLE %windowTitle% Building PAK...
echo Building PAK file for Unreal Engine...
echo.
echo "%stagingdir%\*.*" "..\..\..\*.*" > filelist.txt
utils\UnrealPak.exe "%~dp0%pakname%.pak" -create="%~dp0filelist.txt" -compress
if ERRORLEVEL 1 goto errbuildpak
echo.
echo Cleaning up...
del filelist.txt

:installpak
if not "%autoinstall%" == "true" goto end
TITLE %windowTitle% Installing Mod...
echo Installing Mod...
xcopy /Y /D "%pakname%.pak" "%moddir%\"
del "%pakname%.pak"
goto end

:end
call :ascii
TITLE %windowTitle% All Done!
if "%autoinstall%" == "true" echo All done! Your mod has been installed to your game installation folder as %pakname%.pak.
if not "%autoinstall%" == "true" echo All done! Your mod has been created as %pakname%.pak.
echo.
echo Have fun!
echo Press any key to exit . . .
pause>nul
exit

REM **************************************************************************
REM *******************************  ERRORS  *********************************
REM **************************************************************************

:errdirconfig
TITLE %windowTitle% Error!
echo You have not set the path to your GTA San Andreas installation files. Please edit this script and add a valid path.
echo Check the README for more information
echo.
echo Press any key to exit . . .
pause>nul
exit

:errnocompiler
TITLE %windowTitle% Error!
echo ERROR: "staging\Gameface\Content\OriginalData\GTASA\data\sc.exe" is missing!
echo Script compiler could not be found. Please make sure you are using the correct game build in the staging dir!
echo You need to extract the OriginalData folder from one of the Switch release NSPs into staging\Gameface\Content\
echo Check the README for more information
echo.
echo Press any key to exit . . .
pause>nul
exit

:errnoscript
TITLE %windowTitle% Error!
echo ERROR: "staging\Gameface\Content\OriginalData\GTASA\Scripts\main.sc" is missing!
echo Main script could not be found. Please make sure you are using the correct game build in the staging dir!
echo You need to extract the OriginalData folder from one of the Switch release NSPs into staging\Gameface\Content\
echo Check the README for more information
echo.
echo Press any key to exit . . .
pause>nul
exit

:errcompile
TITLE %windowTitle% Error!
echo.
echo ERROR: Failed to compile game scripts!
echo Something went wrong with the R* script compiler. I've opened the compiler's LogFile.txt for more information.
notepad LogFile.txt
echo.
echo Press any key to exit . . .
pause>nul
exit

:errbuildpak
TITLE %windowTitle% Error!
echo.
echo ERROR: Failed to build PAK file!
echo.
echo Press any key to exit . . .
pause>nul
exit