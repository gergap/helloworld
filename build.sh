#!/bin/bash
# Helper program to build everything with one command.
# Usage: ./build.sh [Debug|Release]

# Default build type is Release
BUILD_TYPE=Release

if [ $# -gt 0 ]; then
    # Override build type
    BUILD_TYPE=$1
fi

rm -rf bld$BUILD_TYPE
mkdir bld$BUILD_TYPE || exit 1
cd bld$BUILD_TYPE || exit 1
cmake -DBUILD_TYPE=$BUILD_TYPE ../src || exit 1
make || exit 1
make test || exit 1
make package || exit 1

echo "Product generation succeeded."
