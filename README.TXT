This is a sample project to demonstrate the usage of CMake, CTest and CPack.
============================================================================
Author: Gerhard Gapmeier, ascolab GmbH


Quick Start
-----------

This folder contains some convenience batch files.

Windows: Execute these batch files from the Visual Studio Command Prompt.
* build.bat: Automatic product generation including test and packaging
* createVSProject.bat: Create VS projects for developing

Linux:
* build.sh: Automatic product generation including test and packaging

Manual Build instructions
-------------------------

# create a build folder for out-of-source build
mkdir bld
cd bld
# create a makefile
cmake ../src
# build the application
make
# execute unit tests
make test
# create setups
make package

For Nightly builds
------------------

TODO: Explain what the build targets Nightly, Experimental are for.

make Nightly

Attention:
Coverage test is only supported on Linux using GCC.
Make sure to fulfill these requirements.

* gcov must be installed
* You MUST NOT use ccache! Otherwise compilation with coverage information may fail.

Create setups for redistribution
--------------------------------

CPack is able to create several installation formats, from Windows installers to Linux RPM and DEB formats,
tarballs and self-extracting tar archives.

make package

Requirements:
* Windows: NSIS must be installed
* Linux: For creating RPMs the rpm utiles must be installed.
