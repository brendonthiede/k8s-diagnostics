FROM ubuntu:22.04 AS base

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get -y install --fix-missing --no-install-recommends \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    gnupg \
    gnupg2 \
    gpg \
    lsb-release \
    software-properties-common && \
    echo deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main >> /etc/apt/sources.list.d/pgdg.list && \
    curl -L https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg && \
    apt-get update && \
    apt-get -y install --fix-missing --no-install-recommends \
    apache2-utils \
    bash \
    bash-completion \
    bird \
    bridge-utils \
    curl \
    dhcping \
    dnsutils \
    ethtool \
    file \
    fping \
    iftop \
    inetutils-traceroute \
    iperf \
    iproute2 \
    ipset \
    iptables \
    iptraf-ng \
    iputils-ping \
    ipvsadm \
    jq \
    less \
    libaio1 \
    mtr \
    netcat-openbsd \
    nftables \
    ngrep \
    nmap \
    openssl \
    postgresql-client-13 \
    scapy \
    socat \
    strace \
    tcpdump \
    tcptraceroute \
    unzip \
    util-linux \
    vim \
    wget \
    \
    && apt-get autoremove -y && apt-get clean

CMD ["/bin/bash","-l"]
