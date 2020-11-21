FROM debian:buster-backports

ARG USER
WORKDIR /

EXPOSE 22

RUN apt update; apt upgrade -y
RUN apt install -y figlet curl zsh emacs git git-flow universal-ctags make tcpdump python3 gcc gdb debhelper
RUN apt install -y openssh-server; mkdir -p /run/sshd; echo "PermitRootLogin yes" > /etc/ssh/sshd_config
RUN apt install -y golang-1.14; update-alternatives --install /usr/bin/go go /usr/lib/go-1.14/bin/go 0 --slave /usr/bin/gofmt gofmt /usr/lib/go-1.14/bin/gofmt

COPY setup-user.sh .
COPY id_rsa.pub .

RUN bash -x ./setup-user.sh

COPY start.sh .


CMD [ "/bin/bash", "start.sh", "buster" ]


