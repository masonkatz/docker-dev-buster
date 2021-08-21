FROM debian:buster-backports

ARG USER
WORKDIR /

EXPOSE 22

RUN apt update; apt upgrade -y
RUN apt install -y \
    curl \
    debhelper \
    emacs \
    figlet \
    golang-1.14 \
    golang-1.15 \
    gcc \
    gdb \
    git \
    git-flow \
    httpie \
    ispell \
    make \
    openssh-server \
    python3 \
    tcpdump \
    universal-ctags \
    xorg \
    zsh

RUN mkdir -p /run/sshd; echo "PermitRootLogin yes" > /etc/ssh/sshd_config
RUN update-alternatives --install /usr/bin/go go /usr/lib/go-1.14/bin/go 0 \
    --slave /usr/bin/gofmt gofmt /usr/lib/go-1.14/bin/gofmt; \
    go get -u golang.org/x/lint/golint; \
    go get -u golang.org/x/tools/cmd/goimports; \
    go get -u github.com/nsf/gocode; \
    GO111MODULE=on go get golang.org/x/tools/gopls@latest;
RUN curl -sSL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.41.1

RUN curl -sSL -o chezmoi.deb https://github.com/twpayne/chezmoi/releases/download/v2.1.4/chezmoi_2.1.4_linux_amd64.deb; dpkg -i chezmoi.deb; rm chezmoi.deb

COPY setup-user.sh .
COPY id_rsa.pub .

RUN bash -x ./setup-user.sh

COPY start.sh .

CMD [ "/bin/bash", "start.sh", "buster" ]


