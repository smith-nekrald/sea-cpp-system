#!/usr/bin/env bash

njobs=12

set -uexo pipefail

# Installing Compilation Packages.
setup_list=(bison build-essential cmake doxygen flex 
    g++ gcc gcc-multilib gfortran git google-perftools sphinx
    graphviz libboost-all-dev libbz2-dev libffi-dev libgflags-dev libgfortran5
    libgoogle-perftools-dev libgraphviz-dev libjsoncpp-dev liblapack-dev 
    liblbfgs-dev liblog4cpp5-dev libmetis-dev libopenblas-dev libpython3-dev 
    make patch pkg-config python3-dev python3-pip python3-setuptools screen 
    subversion uuid-dev uuid-runtime wget zip zlib1g-dev libomp-dev
)

online=${online=1}

if [[ $online -eq 1 ]]; then
    sudo apt-get update 
    sudo apt-get dist-upgrade -f -y
    sudo apt-get install -f -y ${setup_list[@]}
fi

launch_directory=`pwd`
script_path=`readlink -f "${BASH_SOURCE[0]}"`
script_directory=`dirname "$script_path"`
cd "$script_directory"


# Installing ThirParty-HSL
if [ ! -d lib/ThirdParty-HSL/build ]; then
    coinhsl_filename="coinhsl-2022.11.09"
    mkdir -p lib/ThirdParty-HSL/build
    cp lib/Sources-HSL/"${coinhsl_filename}.tar.gz" lib/ThirdParty-HSL/"${coinhsl_filename}.tar.gz"
    cd lib/ThirdParty-HSL
    gunzip "${coinhsl_filename}.tar.gz"
    tar xf "${coinhsl_filename}.tar"
    ln -sf "${coinhsl_filename}" coinhsl
    cd build
    ../configure
    make -j $njobs
    sudo make install
    cd "$script_directory"
fi


# Installing MUMPS
if [ ! -d lib/ThirdParty-Mumps/build ]; then
    mkdir -p lib/ThirdParty-Mumps/build
    cd lib/ThirdParty-Mumps
    ./get.Mumps
    cd build
    ../configure 
    make -j $njobs
    sudo make install
    cd "${script_directory}"
fi


# Installing Metis
if [ ! -d lib/ThirdParty-Metis/build ]; then
    mkdir -p lib/ThirdParty-Metis/build
    cd lib/ThirdParty-Metis
    ./get.Metis
    cd build
    ../configure 
    make -j $njobs
    sudo make install
    cd "${script_directory}"
fi


# Installing ASL
if [ ! -d lib/ThirdParty-ASL/build ]; then
    mkdir -p lib/ThirdParty-ASL/build
    cd lib/ThirdParty-ASL
    ./get.ASL
    cd build
    ../configure
    make -j $njobs
    sudo make install
    cd "${script_directory}"
fi


# Installing IPOPT
if [ ! -d lib/Ipopt/build ]; then
    mkdir -p lib/Ipopt/build
    cd lib/Ipopt/build
    export ADD_CXXFLAGS="-std=c++17 -fopenmp"
    export ADD_FFLAGS="-fopenmp"
    export ADD_CFLAGS="-fopenmp"
    ../configure 
    make -j $njobs
    make test -j $njobs
    sudo make install
    cd "${script_directory}"
fi


# Installing CPPAD
if [ ! -d lib/CppAD/build ]; then
    mkdir -p lib/CppAD/build
    cd lib/CppAD/build
    cmake -D include_ipopt=true -D cppad_cxx_flags="-std=c++17" -D CMAKE_VERBOSE_MAKEFILE=YES ..
    make check -j $njobs
    sudo make install
    cd "${script_directory}"
fi


# Installing Data-Sample
if [ ! -d lib/Data-Sample/build ]; then
    mkdir -p lib/Data-Sample/build
    cd lib/Data-Sample/build
    ../configure -C
    make -j $njobs
    sudo make install
    cd "$script_directory"
fi


# Installing Data-miplib3
if [ ! -d lib/Data-miplib3/build ]; then
    mkdir -p lib/Data-miplib3/build
    cd lib/Data-miplib3/build
    ../configure -C
    make -j $njobs
    sudo make install
    cd "$script_directory"
fi


# Installing Data-Netlib
if [ ! -d lib/Data-Netlib/build ]; then
    mkdir -p lib/Data-Netlib/build
    cd lib/Data-Netlib/build
    ../configure -C
    make -j $njobs
    sudo make install
    cd "$script_directory"
fi


# Installing CoinUtils
if [ ! -d lib/CoinUtils/build ]; then
    mkdir -p lib/CoinUtils/build
    cd lib/CoinUtils/build
    ../configure -C
    make -j $njobs
    make test -j $njobs
    sudo make install
    cd "${script_directory}"
fi


# Installign OSI
if [ ! -d lib/Osi/build ]; then
    mkdir -p lib/Osi/build
    cd lib/Osi/build
    ../configure -C
    make -j $njobs
    make test -j $njobs
    sudo make install 
    cd "${script_directory}"
fi


# Installing CLP
if [ ! -d lib/Clp/build ]; then
    mkdir -p lib/Clp/build
    cd lib/Clp/build
    ../configure -C
    make -j $njobs
    make test -j $njobs
    sudo make install
    cd "${script_directory}"
fi


# Installing CGL
if [ ! -d lib/Cgl/build ]; then
    mkdir -p lib/Cgl/build
    cd lib/Cgl/build
    ../configure -C
    make -j $njobs
    make test -j $njobs
    sudo make install
    cd "${script_directory}"
fi


# Installing Cbc
if [ ! -d lib/Cbc/build ]; then
    mkdir -p lib/Cbc/build
    cd lib/Cbc/build
    ../configure -C
    make -j $njobs
    make test -j $njobs
    sudo make install
    cd "${script_directory}"
fi

cd "$launch_directory"
set +uexo

