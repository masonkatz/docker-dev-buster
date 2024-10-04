#!/bin/bash

PLATFORM=$1

function Banner() {
	figlet $PLATFORM - DevBox | tee /etc/motd
}

function GenHostKeys() {
	case $PLATFORM in
	alpine|alma)
		for key in rsa ecdsa ed25519; do
			if [ ! -e /etc/ssh/ssh_host_${key}_key ]; then
				ssh-keygen -t $key -f /etc/ssh/ssh_host_${key}_key -N ''
			fi
		done
		;;
	*)
		;;
	esac
}

function AllowRootLogin() {
	case $PLATFORM in
	alpine)
		sed -i 's/root:\!/root:\*/' /etc/shadow
		sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
		;;
	alma)
		rm /run/nologin
		;;
	esac
	
	mkdir /root/.ssh
	cp /ssh.pub /root/.ssh/authorized_keys
}

# $1 - Username
# $2 - Dotfiles URL
function UserAdd() {
	useradd -m -s/bin/zsh -p* $1
	cd /home/$1
	chmod 700 .
	
	mkdir .ssh
	cp /ssh.pub .ssh/authorized_keys

	# If persistent volume has SSH keys, copy them into the user account.
	if [ -f /export/.ssh/id_rsa ]; then
		cp /export/.ssh/id_rsa .ssh/
	fi
	if [ -f /export/.ssh/id_rsa.pub ]; then
		cp /export/.ssh/id_rsa.pub .ssh/
	fi

	echo "chezmoi init $2" > .zshrc
	echo "chezmoi apply && zsh" >> .zshrc
	
	chown -R $1.$1 .

	case $PLATFORM in
	buster|bullseye|bookworm)
		usermod -a -G sudo $1
		;;
	esac
}

Banner
GenHostKeys
AllowRootLogin
UserAdd $USER $DOTFILES


/usr/sbin/sshd -D
