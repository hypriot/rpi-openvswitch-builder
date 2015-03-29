
# Pull base image
FROM resin/rpi-raspbian:wheezy
MAINTAINER Dieter Reuter <dieter@hypriot.com>

# Install dependencies
# Install build dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    git \
    build-essential \
    fakeroot \
    python-pip \
    debhelper \
    autoconf \
    automake \
    libssl-dev \
    graphviz \
    python-all \
    python-qt4 \
    python-zopeinterface \
    python-twisted-conch \
    libtool \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Install AWS CLI
RUN pip install awscli

# Clone Open vSwitch
RUN \
    mkdir -p /src && \
    cd /src && \
    git clone https://github.com/openvswitch/ovs.git

# Set working dir
WORKDIR /src/ovs

# Check build dependencies
RUN dpkg-checkbuilddeps

# Building .deb's
#RUN DEB_BUILD_OPTIONS='parallel=8' fakeroot debian/rules binary
#RUN DEB_BUILD_OPTIONS='parallel=8 nocheck' fakeroot debian/rules binary
