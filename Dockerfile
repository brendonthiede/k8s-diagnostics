FROM ubuntu:22.04 AS root

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
    software-properties-common
RUN update-ca-certificates
RUN curl -sSL "https://www.postgresql.org/media/keys/ACCC4CF8.asc" | gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" >/etc/apt/sources.list.d/pgdg.list && \
    curl -sSL "https://packages.redis.io/gpg" | gpg --dearmor -o /etc/apt/trusted.gpg.d/redis-archive-keyring.gpg && \
    echo "deb https://packages.redis.io/deb $(lsb_release -cs) main" >/etc/apt/sources.list.d/redis.list && \
    curl -sSL "https://packages.microsoft.com/keys/microsoft.asc" >/etc/apt/trusted.gpg.d/microsoft.asc && \
    curl -sSL "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list" >/etc/apt/sources.list.d/mssql-release.list
RUN apt-get update && \
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
    sudo \
    tcpdump \
    tcptraceroute \
    unzip \
    util-linux \
    vim \
    wget
RUN ACCEPT_EULA=Y apt-get -y install --fix-missing --no-install-recommends \
    mssql-tools18 \
    unixodbc-dev
ENV PATH="$PATH:/opt/mssql-tools18/bin"

CMD ["/bin/bash","-l"]

FROM root AS nonroot
RUN useradd -m -s /bin/bash -u 10000 -U -G sudo -p $(openssl passwd -1 pass) diagnostics && \
    echo "diagnostics ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER diagnostics
WORKDIR /home/diagnostics
CMD ["tail","-f","/dev/null"]
