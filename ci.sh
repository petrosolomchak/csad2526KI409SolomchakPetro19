#!/bin/bash

CMAKE_OPTIONS="-DBUILD_TESTING=ON"

mkdir -p build
cd build || exit 1

cmake .. ${CMAKE_OPTIONS}

if [ $? -ne 0 ]; then
    exit 1
fi

cmake --build . --config Release

if [ $? -ne 0 ]; then
    exit 1
fi

ctest --output-on-failure

if [ $? -ne 0 ]; then
    exit 1
fi
