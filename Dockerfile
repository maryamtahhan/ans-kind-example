FROM fedora:38

# Setup container to build DPDK applications
RUN dnf -y upgrade && dnf -y install \
    iproute socat
