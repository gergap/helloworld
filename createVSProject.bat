@echo off
REM Windows batch file for creating Visual Studio projects.
REM This is used for developers, not for product generation.

REM Load environment settings from env.bat
CALL env.bat

REM DON'T MODIFY BELOW THIS LINE

IF NOT EXIST "bldVS" GOTO CreateDir
RMDIR /Q /S bldVS
IF ERRORLEVEL 1 GOTO Error

:CreateDir
mkdir bldVS
IF ERRORLEVEL 1 GOTO Error

cd bldVS
IF ERRORLEVEL 1 GOTO Error

REM The default generator create VS projects
cmake -DCMAKE_INSTALL_PREFIX=..\dist ..\src
IF ERRORLEVEL 1 GOTO Error

cd ..
GOTO End

:Error
echo "VS project generation failed."

:End
echo "VS project generation succeeded."
