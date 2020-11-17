FROM debian:buster-backports

WORKDIR /

EXPOSE 22

RUN apt update; apt upgrade -y
RUN apt install -y figlet curl zsh emacs vim git make tcpdump gcc
RUN apt install -y openssh-server; mkdir -p /run/sshd; echo "PermitRootLogin yes" > /etc/ssh/sshd_config
RUN apt install -y golang-1.14; update-alternatives --install /usr/bin/go go /usr/lib/go-1.14/bin/go 0 --slave /usr/bin/gofmt gofmt /usr/lib/go-1.14/bin/gofmt

RUN chsh root -s /usr/bin/zsh; \
	git clone https://github.com/masonkatz/env.git /root/env; \
	cd /root/env; \
	make clean install

COPY id_rsa.pub .
COPY start.sh .

CMD [ "/bin/bash", "start.sh" ]


