#! /bin/bash

useradd -m -s/bin/zsh -p* $USER
HOME=/home/$USER
cd $HOME


mkdir .ssh
cp /id_rsa.pub .ssh/authorized_keys
chmod 700 $HOME


git clone https://github.com/masonkatz/env.git
cd env
#make clean install

chown -R $USER.$USER $HOME

