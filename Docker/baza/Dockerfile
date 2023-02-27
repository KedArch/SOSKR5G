FROM ubuntu:focal

RUN mkdir -p /etc/open5gs /var/log/open5gs && \
    apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        python3-pip \
        python3-setuptools \
        python3-wheel \
        ninja-build \
        build-essential \
        flex \
        bison \
        git \
        cmake \
        meson \
        libsctp-dev \
        libgnutls28-dev \
        libgcrypt-dev \
        libssl-dev \
        libidn11-dev \
        libmongoc-dev \
        libbson-dev \
        libyaml-dev \
        libmicrohttpd-dev \
        libcurl4-gnutls-dev \
        libnghttp2-dev \
        libtins-dev \
        libtalloc-dev \
        iproute2 \
        ca-certificates \
        netbase \
        pkg-config \
        software-properties-common && \
    apt-get clean
