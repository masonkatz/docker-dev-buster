FROM almalinux:latest

WORKDIR /

EXPOSE 22


RUN yum upgrade -y
RUN dnf install -y epel-release

RUN yum install -y \
    ctags \
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

RUN curl -sSL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.46.0

RUN sh -c "$(curl -fsLS chezmoi.io/get)"

COPY ssh.pub .
COPY start.sh .

CMD [ "/bin/bash", "start.sh", "alma" ]


