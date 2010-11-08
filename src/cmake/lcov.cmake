# - This module creates a new 'lcov' target which generates
#   a coverage analysis html output.
# LCOV is a graphical front-end for GCC's coverage testing tool gcov.  Please see
# http://ltp.sourceforge.net/coverage/lcov.php
#
# Usage: you must add an option to your CMakeLists.txt to build your application
# with coverage support. Then you need to include this file to the lcov target.
#
# Example:
# IF(BUILD_WITH_COVERAGE)
#   SET(CMAKE_C_FLAGS "-g -O0 -Wall -fprofile-arcs -ftest-coverage")
#   SET(CMAKE_CXX_FLAGS "-g -O0 -Wall -fprofile-arcs -ftest-coverage")
#   SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fprofile-arcs -ftest-coverage -lgcov")
#   include(${CMAKE_SOURCE_DIR}/cmake/lcov.cmake)
# ENDIF(BUILD_WITH_COVERAGE)
#=============================================================================
# Copyright 2010 ascolab GmbH
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distributed this file outside of CMake, substitute the full
#  License text for the above reference.)

## lcov target
ADD_CUSTOM_TARGET(lcov)
ADD_CUSTOM_COMMAND(TARGET lcov
    COMMAND mkdir -p coverage
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    )
ADD_CUSTOM_COMMAND(TARGET lcov
    COMMAND lcov --directory . --zerocounters
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    )
ADD_CUSTOM_COMMAND(TARGET lcov
    COMMAND make test
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    )
ADD_CUSTOM_COMMAND(TARGET lcov
    COMMAND lcov --directory . --capture --output-file ./coverage/stap.info
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    )
ADD_CUSTOM_COMMAND(TARGET lcov
    COMMAND genhtml -o ./coverage ./coverage/stap.info
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    )
ADD_CUSTOM_COMMAND(TARGET lcov
    COMMAND echo "Open ${CMAKE_BINARY_DIR}/coverage/index.html to view the coverage analysis results."
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    )
ADD_DEPENDENCIES(lcov helloworld)


