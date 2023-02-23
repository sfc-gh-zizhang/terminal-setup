#!/bin/bash

if [ "$EUID" -ne 0 ]
    then echo "error: please run this script with ROOT privileges"
    exit
fi

export OLD_PATH=$PATH
export PATH=/opt/rh/devtoolset-8/root/usr/bin:$PATH
gcc -v
echo "Please confirm if the verison of gcc being used is 8.3.1. If yes, please reply with y. If no, please reply with n"
read response
if [[ $response == "y" || $response == "Y" ]]; then
    echo "confirmed"
else
    echo "exit, the version of gcc is not correct"
    export PATH=$OLD_PATH
    exit 1
fi
make -v
echo "Please confirm if the verison of make being used is 4.2.1. If yes, please reply with y. If no, please reply with n"
read response
if [[ $response == "y" || $response == "Y" ]]; then
    echo "confirmed"
else
    echo "exit, the version of make is not correct"
    export PATH=$OLD_PATH
    exit 1
fi

echo "Downloading glibc 2.28"
wget -c http://ftp.gnu.org/gnu/glibc/glibc-2.28.tar.gz
tar -xf glibc-2.28.tar.gz
cd glibc-2.28
mkdir build
cd build
../configure --prefix=/usr --disable-profile --enable-add-ons --with-headers=/usr/include --with-binutils=/usr/bin
make
make install
cd ../..
rm glibc-2.28.tar.gz
rm -rf ./glibc-2.28

strings /lib64/libc.so.6 | grep GLIBC
echo "Please confirm if GLIBC_2.28 is installed. If yes, please reply with y. If no, please reply with n"
read response
if [[ $response == "y" || $response == "Y" ]]; then
    echo "confirmed"
else
    echo "exit, GLIBC_2.28 is not installed successfully"
    export PATH=$OLD_PATH
    exit 1
fi

echo "Downloading miniconda aarch64"
wget -c https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh

echo "Installing miniconda aarch64"
sh Miniconda3-latest-Linux-aarch64.sh -u

conda -V
rm -rf Miniconda3-latest-Linux-aarch64.sh
export PATH=$OLD_PATH