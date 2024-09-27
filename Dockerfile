FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get -y install --fix-missing --no-install-recommends apt-utils gnupg wget && \
    echo deb http://apt.postgresql.org/pub/repos/apt/ focal-pgdg main >> /etc/apt/sources.list.d/pgdg.list && \
    wget https://www.postgresql.org/media/keys/ACCC4CF8.asc --no-check-certificate && \
    apt-key add ACCC4CF8.asc && \
    apt-get update && \
    apt-get -y install --fix-missing --no-install-recommends apt-utils \
    apache2-utils \
    bash \
    bird \
    bridge-utils \
    curl \
    curl \
    dhcping \
    dnsutils \
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
    util-linux \
    vim \
    \
    && apt-get autoremove -y && apt-get clean

CMD ["/bin/bash","-l"]
