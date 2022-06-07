FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
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
    jq \
    libaio1 \
    mtr \
    netcat-openbsd \
    nftables \
    ngrep \
    nmap \
    openssl \
    postgresql-client \
    scapy \
    socat \
    strace \
    tcpdump \
    tcptraceroute \
    util-linux \
    vim \
    wget \
    \
    && apt-get autoremove -y && apt-get clean

CMD ["/bin/bash","-l"]
