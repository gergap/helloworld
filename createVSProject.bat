@echo off
REM Windows batch file for creating Visual Studio projects.
REM This is used for developers, not for product generation.

REM Typically the tools are not in the windows search path so we configure that here.
REM Change this to your needs.
SET PATH="%PROGRAMFILES%\CMake 2.9\bin";%PATH%

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
cmake ..\src
IF ERRORLEVEL 1 GOTO Error

cd ..
GOTO End

:Error
echo "VS project generation failed."

:End
echo "VS project generation succeeded."
