FROM ubuntu:22.04 AS base

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y && \
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
    update-ca-certificates && \
    curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" >/etc/apt/sources.list.d/pgdg.list && \
    curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/redis-archive-keyring.gpg && \
    echo "deb https://packages.redis.io/deb $(lsb_release -cs) main" >/etc/apt/sources.list.d/redis.list && \
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
    redis-tools \
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
    && apt-get autoremove -y

CMD ["/bin/bash","-l"]
