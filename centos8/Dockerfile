FROM centos:centos8

ARG USER
WORKDIR /

EXPOSE 22

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN yum upgrade -y

RUN yum install -y \
    ctags \
    curl \
    emacs \
    figlet \
    gcc \
    gdb \
    git \
    golang \
    make \
    openssh-server \
    passwd \
    python3 \
    rpm-build \
    rpmlint \
    rpm-devel \
    rpmdevtools \
    sudo \
    tcpdump \
    zsh

COPY setup-user.sh .
COPY id_rsa.pub .

RUN bash -x ./setup-user.sh

COPY start.sh .


CMD [ "/bin/bash", "start.sh", "centos8" ]


