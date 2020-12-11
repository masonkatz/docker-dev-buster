#! /bin/bash

useradd -m -s/bin/zsh -p* $USER
HOME=/home/$USER
cd $HOME


mkdir /root/.ssh
cp /id_rsa.pub /root/.ssh/authorized_keys

mkdir .ssh
cp /id_rsa.pub .ssh/authorized_keys
chmod 700 $HOME


git clone https://github.com/masonkatz/env.git
cat > .zshrc <<EOF

echo 'Type "cd env; make clean install" to complete configuration'

EOF

chown -R $USER.$USER $HOME

