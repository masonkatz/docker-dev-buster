FROM centos:centos8

ARG USER
WORKDIR /

EXPOSE 22

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN yum upgrade -y

RUN yum install -y figlet curl zsh emacs git ctags make tcpdump python3 gcc gdb rpm-build rpmdevtools
RUN yum install -y openssh-server
RUN yum install -y golang

COPY setup-user.sh .
COPY id_rsa.pub .

RUN bash -x ./setup-user.sh

COPY start.sh .


CMD [ "/bin/bash", "start.sh", "centos8" ]


