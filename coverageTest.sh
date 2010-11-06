#!/bin/bash
# Helper program to build everything with one command.
# Usage: ./build.sh [Debug|Release]

# Default build type is Release
BUILD_TYPE=Debug
BLDDIR=bldCoverage
CMAKE_OPTIONS=-DBUILD_WITH_COVERAGE=ON

if [ $# -gt 0 ]; then
    # Override build type
    BUILD_TYPE=$1
fi

rm -rf $BLDDIR
mkdir $BLDDIR || exit 1
cd $BLDDIR || exit 1
cmake -DBUILD_TYPE=$BUILD_TYPE $CMAKE_OPTIONS ../src || exit 1
make lcov || exit 1

echo "Coverage analysis completed."
