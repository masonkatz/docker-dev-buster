FROM alpine:latest

ARG USER
WORKDIR /

EXPOSE 22

RUN apk update; apk upgrade
RUN apk add \
    bash \
    binutils \
    chezmoi \
    coreutils \
    ctags \
    curl \
    emacs \
    figlet \
    findutils \
    gcc \
    gdb \
    git \
    go \
    grep \
    httpie \
    less \
    make \
    ncurses \
    openssh-client \
    openssh-server \
    python3 \
    shadow \
    tcpdump \
    util-linux \
    zsh

RUN curl -sSL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.41.1

COPY setup-user.sh .
COPY id_rsa.pub .

RUN bash -x ./setup-user.sh

COPY start.sh .


CMD [ "/bin/bash", "start.sh", "alpine" ]


