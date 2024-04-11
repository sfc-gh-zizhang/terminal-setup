#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

USERNAME=$1
sudo -E yum -y groupinstall "Development tools"
sudo -E yum -y install ncurses-devel
wget https://sourceforge.net/projects/zsh/files/zsh/5.6.2/zsh-5.6.2.tar.xz/download
tar -xvJf download
cd zsh-5.6.2
./configure
make
make install
echo "/usr/local/bin/zsh-5.6.2" >> /etc/shells
chsh -s /usr/local/bin/zsh-5.6.2
chsh -s /usr/local/bin/zsh-5.6.2 $USERNAME

