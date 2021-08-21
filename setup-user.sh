#! /bin/bash

useradd -m -s/bin/zsh -p* $USER
HOME=/home/$USER
cd $HOME


mkdir /root/.ssh
cp /id_rsa.pub /root/.ssh/authorized_keys

mkdir .ssh
cp /id_rsa.pub .ssh/authorized_keys
chmod 700 $HOME


chezmoi init https://github.com/masonkatz/dotfiles.git

cat > .zshrc <<EOF
echo
echo
chezmoi init
chezmoi apply && zsh
EOF

chown -R $USER.$USER $HOME
usermod -a -G wheel $USER

true


