#!/bin/bash

PLATFORM=$1

figlet DevBox
figlet $PLATFORM
uname -a

if [ "$PLATFORM" = "centos8" ]; then
	for key in rsa ecdsa ed25519; do
		if [ ! -e /etc/ssh/ssh_host_${key}_key ]; then
			ssh-keygen -t $key -f /etc/ssh/ssh_host_${key}_key -N ''
		fi
	done
	rm /run/nologin
fi

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
		chown -R $user.$user /home/$user/.ssh
	fi
done

/usr/sbin/sshd -D
