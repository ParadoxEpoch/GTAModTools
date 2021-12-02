@echo off
cd %~dp0
if exist keys.dat goto start
if exist keys.txt move keys.txt keys.dat

:start
cls
echo.
echo     --------------------------------------------------------
echo          NSP Extractor for Paradox's GTA DE Mod Builder
echo        Github: github.com/maega ^| Twitter: @ParadoxEpoch
echo.
echo             Credit to Sonansune on GBATemp for tf.exe
echo                and SciresM for the awesome hactool
echo     --------------------------------------------------------
echo.
if not exist keys.dat goto missingkeys
if not "%~x1" == ".nsp" goto badinput

:decryptNSP
mkdir nsp_workingdir\decrypted
set filename=%~n1
title Decrypting "%~n1%~x1"...
echo Decrypting "%~n1%~x1"...
utils\hactool.exe -k "%~dp0keys.dat" -t pfs0 --pfs0dir=nsp_workingdir\decrypted "%~1" > nul

:getTitlekey
echo.
echo Extracting TitleKey...
(for %%J in (nsp_workingdir\decrypted\*.tik) do (for /f %%K in ('"%~dp0utils\tf.exe" %%J') do set titlekey=%%K))>nul
echo TitleKey: %titlekey%

:findNCA
echo.
echo Finding data NCA...
dir "nsp_workingdir\decrypted" /b /o-s > nsp_workingdir\dir_list.txt
set /P nca_file= < nsp_workingdir\dir_list.txt
del nsp_workingdir\dir_list.txt
echo Target NCA: %nca_file%

:extractNCA
echo.
title Extracting NCA Data...
echo Extracting Game Data NCA...
mkdir nsp_workingdir\extracted
utils\hactool.exe -k "%~dp0keys.dat" --titlekey=%titlekey% --section0dir="nsp_workingdir\extracted" --section1dir="nsp_workingdir\extracted" --section2dir="nsp_workingdir\extracted" --section3dir="nsp_workingdir\extracted" "nsp_workingdir\decrypted\%nca_file%"
move "nsp_workingdir\extracted\Gameface\Content\Paks\pakchunk0-Switch.pak" "%~dp0"

:cleanup
echo.
echo Cleaning up...
rmdir "nsp_workingdir" /s /q

echo.
echo Extraction Finished!
echo You can now extract the .pak file that was output by dragging it onto the Extract_PAK.bat script.
echo You can also safely delete the NSP file at this point.
echo.
echo Press any key to exit . . .
pause>nul
exit

:badinput
echo You need to drag a Switch NSP (.nsp) onto this batch file to use this script!
echo.
echo Press any key to exit . . .
pause>nul
exit

:missingkeys
echo You need a keys.txt/keys.dat file to use this script. You can get this from your Switch or find a copy online.
echo.
echo Press any key to exit . . .
pause>nul
exit