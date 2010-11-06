This is a sample project to demonstrate the usage of CMake, CTest and CPack.
============================================================================
Copyright (C) 2010 Gerhard Gappmeier, ascolab GmbH


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

Coverage Analysis using GCOV and LCOV
-------------------------------------

The generated Makefile contains a custom build target "lcov" which executes the
unit tests and generates the coverage report using lcov.
You need to build the application with coverage option turned on so that lcov works.

Requirements:
* Linux and GCC compiler
* GCOV
* LCOV

# create a build folder for out-of-source build
mkdir bld
cd bld
# create a makefile
cmake -DBUILD_WITH_COVERAGE=on ../src
# build the application
make
# execute coverage analysis
make lcov
# view results in your favorite browser (konqueror, firefox, or what ever you prefer)
konqueror coverage/index.html

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

