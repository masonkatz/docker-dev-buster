FROM debian:bookworm-backports

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

RUN curl -sSL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b /usr/local/bin v1.46.0

RUN sh -c "$(curl -fsLS chezmoi.io/get)"

COPY ssh.pub .
COPY start.sh .

CMD [ "/bin/bash", "start.sh", "bookworm" ]


