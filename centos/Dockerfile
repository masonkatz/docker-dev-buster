FROM quay.io/centos/centos:stream

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

RUN curl -sSL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.41.1

RUN curl -sSL -o chezmoi.rpm https://github.com/twpayne/chezmoi/releases/download/v2.1.4/chezmoi-2.1.4-x86_64.rpm; rpm -Uhv chezmoi.rpm; rm chezmoi.rpm

COPY setup-user.sh .
COPY id_rsa.pub .

RUN bash -x ./setup-user.sh

COPY start.sh .


CMD [ "/bin/bash", "start.sh", "centos8" ]


