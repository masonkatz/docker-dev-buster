#!/bin/bash

PLATFORM=$1

figlet DevBox
figlet $PLATFORM
uname -a

# If the mounted volme has SSH keys, copy them into the user account.

cd /home
for user in *; do
	if [ -d $user ]; then
		if [ -f /export/.ssh/id_rsa ]; then
			cp /export/.ssh/id_rsa /home/$user/.ssh/
		fi
		if [ -f /export/.ssh/id_rsa.pub ]; then
			cp /export/.ssh/id_rsa.pub /home/$user/.ssh/
		fi
	fi
done

/usr/sbin/sshd -D
