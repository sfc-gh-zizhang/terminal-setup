#!/bin/bash

sudo -E yum groupinstall "Development tools"
sudo -E yum install ncurses-devel
wget https://sourceforge.net/projects/zsh/files/zsh/5.6.2/zsh-5.6.2.tar.xz/download
tar -xvJf download
cd zsh-5.6.2
./configure
sudo make
sudo make install
echo "/usr/local/bin/zsh-5.6.2" >> /etc/shells
chsh -s /usr/local/bin/zsh-5.6.2
chsh -s /usr/local/bin/zsh-5.6.2 $USER
