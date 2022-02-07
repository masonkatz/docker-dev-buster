FROM debian:bullseye-backports

WORKDIR /

EXPOSE 22

RUN apt update; apt upgrade -y
RUN apt install -y \
    curl \
    debhelper \
    emacs \
    figlet \
    gcc \
    gdb \
    git \
    git-flow \
    golang \
    httpie \
    ispell \
    make \
    openssh-server \
    python3 \
    sudo \
    tcpdump \
    universal-ctags \
    xorg \
    zsh

RUN mkdir -p /run/sshd; echo "PermitRootLogin yes" > /etc/ssh/sshd_config
RUN go get -u golang.org/x/lint/golint; \
    go get -u golang.org/x/tools/cmd/goimports; \
    GO111MODULE=on go get golang.org/x/tools/gopls@latest;
RUN curl -sSL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.44.0

RUN sh -c "$(curl -fsLS chezmoi.io/get)"

RUN curl -fsSL https://pkgs.tailscale.com/stable/debian/bullseye.gpg | apt-key add -; \
    curl -fsSL https://pkgs.tailscale.com/stable/debian/bullseye.list | tee /etc/apt/sources.list.d/tailscale.list; \
    apt update; apt install -y tailscale

COPY id_rsa.pub .
COPY start.sh .

CMD [ "/bin/bash", "start.sh", "bullseye" ]


