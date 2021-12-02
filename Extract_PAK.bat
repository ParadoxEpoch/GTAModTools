@echo off
cd %~dp0

echo.
echo     --------------------------------------------------------
echo          PAK Extractor for Paradox's GTA DE Mod Builder
echo        Github: github.com/maega ^| Twitter: @ParadoxEpoch
echo     --------------------------------------------------------
echo.
if not "%~x1" == ".pak" goto badinput

title Unpacking "%~n1%~x1"...
echo Unpacking "%~n1%~x1"...
mkdir staging
utils\quickbms_4gb_files.exe "%~dp0utils\unreal_tournament_4_0.4.27a_paks_only.bms" "%~1" "%~dp0staging"
echo.
echo Extraction Finished!
echo.
echo Press any key to exit . . .
pause>nul
exit

:badinput
echo You need to drag an Unreal PAK (.pak) onto this batch file to use this script!
echo.
echo Press any key to exit . . .
pause>nul
exit