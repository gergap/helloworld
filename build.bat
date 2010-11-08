@echo off
REM Windows batch file for building the product
REM Be sure to start the from a command line which is configured for your Visual Studio.
REM Use Start->Programs->Microsoft Visual Studio 2008->Visual Studio Tools->Visual Studio 2008 Command Prompt
REM to open the command prompt.

REM Load environment settings from env.bat
CALL env.bat

REM DON'T MODIFY BELOW THIS LINE

REM default build type
SET BUILD_TYPE=Release
SET GENERATOR="NMake Makefiles"

IF NOT EXIST "bld%BUILD_TYPE%" GOTO CreateDir
RMDIR /Q /S bld%BUILD_TYPE%
IF ERRORLEVEL 1 GOTO Error

:CreateDir
mkdir bld%BUILD_TYPE%
IF ERRORLEVEL 1 GOTO Error

cd bld%BUILD_TYPE%
IF ERRORLEVEL 1 GOTO Error

cmake -G %GENERATOR% ..\src
IF ERRORLEVEL 1 GOTO Error

nmake
IF ERRORLEVEL 1 GOTO Error

nmake test
IF ERRORLEVEL 1 GOTO Error

nmake package
IF ERRORLEVEL 1 GOTO Error

cd ..
GOTO End

:Error
echo "Product generation failed."

:End
echo "Product generation succeeded."
