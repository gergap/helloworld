@echo off
REM Typically the tools are not in the windows search path so we configure that here.
REM Change this to your needs.

REM Add Default CMake 2.8 path
SET PATH="%PROGRAMFILES%\CMake 2.8\bin";%PATH%

REM Add Default CMake 2.9 path
SET PATH="%PROGRAMFILES%\CMake 2.9\bin";%PATH%

REM Add Default NSIS path
SET PATH="%PROGRAMFILES%\NSIS";%PATH%

REM Add Default Doxygen path
SET PATH="%PROGRAMFILES%\doxygen\bin";%PATH%

