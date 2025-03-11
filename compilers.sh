#!/usr/bin/env bash

# Script to activate desired C++ compilers.

# Author: Aliaksandr Nekrashevich
# Email: aliaksandr.nekrashevich@queensu.ca
# (c) Smith School of Business, 2025

export PATH="$PATH":/usr/local/gcc-14.2.0/bin:/usr/lib/llvm-19/bin
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH":/usr/local/gcc-14.2.0/lib64:/usr/lib/llvm-19/lib
export ASAN_OPTIONS=detect_leaks=0

c_compiler="gcc-14.2.0"
cxx_compiler="g++-14.2.0"

if ! $c_compiler --version; then
    c_compiler=gcc
fi

if ! $cxx_compiler --version; then
    cxx_compiler=g++
fi

export CMAKE_C_COMPILER="$c_compiler"
export CMAKE_CC_COMPILER="$c_compiler"
export CMAKE_CXX_COMPILER="$cxx_compiler"
export C="$c_compiler"
export CC="$c_compiler"
export CXX="$cxx_compiler"

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
export CPATH="$CPATH:/usr/local/include/coin-or/glpk:/usr/local/include/coin-or"
export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:/usr/local/include/coin-or/glpk"
export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:/usr/local/include/coin-or "
export C_INCLUDE_PATH="$C_INCLUDE_PATH:/usr/local/include/coin-or/glpk"
