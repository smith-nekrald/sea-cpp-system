#!/usr/bin/env bash

# Script to activate desired C++ compilers.

# Author: Aliaksandr Nekrashevich
# Email: aliaksandr.nekrashevich@queensu.ca
# (c) Smith School of Business, 2025

export PATH="$PATH":/usr/local/gcc-14.2.0/bin
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH":/usr/local/gcc-14.2.0/lib64
export CMAKE_C_COMPILER="gcc-14.2.0"
export CMAKE_CXX_COMPILER="g++-14.2.0"
export C="gcc-14.2.0"
export CC="g++-14.2.0"
export CXX="g++-14.2.0"

