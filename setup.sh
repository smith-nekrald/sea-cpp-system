#!/usr/bin/env bash

set -uexo pipefail

# Installing Compilation Packages.
setup_list=(bison build-essential cmake doxygen flex 
    g++ gcc gcc-multilib gfortran git google-perftools 
    graphviz libboost-all-dev libbz2-dev libffi-dev libgflags-dev libgfortran5
    libgoogle-perftools-dev libgraphviz-dev libjsoncpp-dev liblapack-dev 
    liblbfgs-dev liblog4cpp5-dev libmetis-dev libopenblas-dev libpython3-dev 
    make patch pkg-config python3-dev python3-pip python3-setuptools screen 
    subversion uuid-dev uuid-runtime wget zip zlib1g-dev
)

sudo apt-get update 
sudo apt-get dist-upgrade -f -y
sudo apt-get install -f -y ${setup_list[@]}

git submodule update --init --recursive
script_directory=`pwd`


# Installing ThirParty-HSL
coinhsl_filename="coinhsl-archive-2022.12.02"
mkdir -p lib/ThirdParty-HSL/build
cp lib/Sources-HSL/"${coinhsl_filename}.tar.gz"  lib/ThirdParty-HSL/"${coinhsl_filename}.tar.gz"
cd lib/ThirdParty-HSL
gunzip "${coinhsl_filename}.tar.gz"
tar xf "${coinhsl_filename}.tar"
ln -sf "${coinhsl_filename}" coinhsl
cd build
../configure
make
sudo make install
cd "$script_directory"


# Installing MUMPS
mkdir -p lib/ThirdParty-Mumps/build
cd lib/ThirdParty-Mumps
./get.Mumps
cd build
../configure 
make
sudo make install
cd "${script_directory}"


# Installing ASL
mkdir -p lib/ThirdParty-ASL/build
cd lib/ThirdParty-ASL
./get.ASL
cd build
../configure
make
sudo make install
cd "${script_directory}"


# Installing IPOPT
mkdir -p lib/Ipopt/build
cd lib/ThirdParty-ASL/build
../configure
make
make test
sudo make install
cd "${script_directory}"


# Installing CPPAD
mkdir -p lib/CppAD/build
cd lib/CppAD/build
cmake -D include_ipopt=true ..
make check
sudo make install
cd "${script_directory}"


# Installing Data-Sample
mkdir -p lib/Data-Sample/build
cd lib/Data-Sample/build
../configure -C
make
sudo make install
cd "$script_directory"


# Installing Data-miplib3
mkdir -p lib/Data-miplib3/build
cd lib/Data-miplib3/build
../configure -C
make
sudo make install
cd "$script_directory"


# Installing Data-Netlib
mkdir -p lib/Data-Netlib/build
cd lib/Data-Netlib/build
../configure -C
make
sudo make install
cd "$script_directory"


# Installing CoinUtils
mkdir -p lib/CoinUtils/build
cd lib/CoinUtils/build
../configure -C
make
make test
sudo make install
cd "${script_directory}"


# Installign OSI
mkdir -p lib/Osi/build
cd lib/Osi/build
../configure -C
make
make test
sudo make install 
cd "${script_directory}"


# Installing CLP
mkdir -p lib/Clp/build
cd lib/Clp/build
../configure -C
make
make test
sudo make install
cd "${script_directory}"


# Installing CGL
mkdir -p lib/Cgl/build
cd lib/Cgl/build
../configure -C
make
make test
sudo make install
cd "${script_directory}"


# Installing Cbc
mkdir -p lib/Cbc/build
cd lib/Cbc/build
../configure -C
make
make test
sudo make install
cd "${script_directory}"

set +uexo

