FROM debian:buster-backports

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
    httpie \
    ispell \
    lsb-release \
    make \
    openssh-server \
    python3 \
    silversearcher-ag \
    sudo \
    tcpdump \
    universal-ctags \
    vim \
    xorg \
    zsh

RUN mkdir -p /run/sshd; echo "PermitRootLogin yes" > /etc/ssh/sshd_config
RUN sed -i 's/ ALL/ NOPASSWD: ALL/g' /etc/sudoers
RUN rm /etc/emacs/site-start.d/*

RUN arch=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/); \
    curl -sSfL https://dl.google.com/go/go1.18.2.linux-$arch.tar.gz | tar -C /usr/local -xzf -; \
    update-alternatives --install /usr/bin/go go /usr/local/go/bin/go 0 --slave /usr/bin/gofmt gofmt /usr/local/go/bin/gofmt; \
    go install golang.org/x/lint/golint@latest; \
    go install golang.org/x/tools/cmd/goimports@latest; \
    go install golang.org/x/tools/gopls@latest; \
    mv /root/go/bin/* /usr/local/bin;

RUN curl -sSL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b /usr/local/bin v1.46.0

RUN sh -c "$(curl -fsLS chezmoi.io/get)"

COPY id_rsa.pub .
COPY start.sh .

CMD [ "/bin/bash", "start.sh", "buster" ]


