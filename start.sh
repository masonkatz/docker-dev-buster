#!/bin/bash

figlet Debian Buster Develop

mkdir /root/.ssh
cat /id_rsa.pub > /root/.ssh/authorized_keys
rm /id_rsa.pub

/usr/sbin/sshd -D
