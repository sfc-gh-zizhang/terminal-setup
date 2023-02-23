#!/bin/bash

sudo yum -y install patchelf

# export OLD_PATH=$PATH
# export PATH=/opt/rh/devtoolset-8/root/usr/bin:$PATH
# gcc -v
# echo "Please confirm if the verison of gcc being used is 8.3.1. If yes, please reply with y. If no, please reply with n"
# read response
# if [[ $response == "y" || $response == "Y" ]]; then
#     echo "confirmed"
# else
#     echo "exit, the version of gcc is not correct"
#     exit 1
# fi
# make -v
# echo "Please confirm if the verison of make being used is 4.2.1. If yes, please reply with y. If no, please reply with n"
# read response
# if [[ $response == "y" || $response == "Y" ]]; then
#     echo "confirmed"
# else
#     echo "exit, the version of make is not correct"
#     exit 1
# fi

echo "Installing glibc"
libc_version=2.28
wget -c http://ftp.gnu.org/gnu/glibc/glibc-${libc_version}.tar.gz
tar -xf glibc-${libc_version}.tar.gz
cd glibc-${libc_version}
mkdir build
cd build
../configure --prefix=/opt/glibc${libc_version}
make -j6
sudo make install

echo "Installing miniconda3"
wget -c https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh
sed -i '344i\
patchelf --set-interpreter /opt/glibc2.28/lib/ld-linux-aarch64.so.1 $CONDA_EXEC\
patchelf --set-rpath /opt/glibc2.28/lib:/usr/lib64 $CONDA_EXEC' Miniconda3-latest-Linux-aarch64.sh

echo "Reminder: do not install to the default directory: /root/miniconda3. Enter any key to continue."
read response
sudo bash Miniconda3-latest-Linux-aarch64.sh -u

# echo 
# """
# Use following commands to let python use glibc2.28:

# patchelf --set-interpreter /opt/glibc2.28/lib/ld-linux-aarch64.so.1 CONDA_DIR/bin/python
# patchelf --set-rpath /opt/glibc2.28/lib:/usr/lib64 CONDA_DIR/bin/python

# """