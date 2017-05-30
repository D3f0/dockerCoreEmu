FROM ubuntu:16.04
MAINTAINER Stuart Marsden <stuartmarsden@finmars.co.uk>
ENV WIDTH 1920
ENV HEIGHT 1080
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -qq -y xvfb x11vnc x11-apps \
                           wget libjbig0 libtcl8.5 libtiff5 libtk-img libtk8.5 tcl8.5 tk8.5 \
                           openbox \
                           bridge-utils ebtables iproute libev4 libev-dev python libxml2 \
                           libprotobuf9v5 python-protobuf libpcap0.8 libpcre3 libuuid1 \
                           libace-6.3.3 python-lxml python-setuptools \
                           traceroute mgen openssh-server iperf tcpdump wireshark && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN wget http://downloads.pf.itd.nrl.navy.mil/core/packages/4.8/core-daemon_4.8-0ubuntu1_trusty_amd64.deb && \
    dpgk -i core-daemon_4.8-0ubuntu1_trusty_amd64.deb && rm -rf core-daemon_4.8-0ubuntu1_trusty_amd64.deb

RUN wget http://downloads.pf.itd.nrl.navy.mil/core/packages/4.8/core-gui_4.8-0ubuntu1_trusty_all.deb && \
    dpkg -i core-gui_4.8-0ubuntu1_trusty_all.deb && rm -rf core-gui_4.8-0ubuntu1_trusty_all.deb

RUN wget http://downloads.pf.itd.nrl.navy.mil/ospf-manet/quagga-0.99.21mr2.2/quagga-mr_0.99.21mr2.2_amd64.deb && \
    dpkg -i quagga-mr_0.99.21mr2.2_amd64.deb && rm -rf quagga-mr_0.99.21mr2.2_amd64.deb

RUN wget http://adjacentlink.com/downloads/emane/emane-0.9.2-release-1.ubuntu-14_04.amd64.tar.gz && \
    tar zxvf emane-0.9.2-release-1.ubuntu-14_04.amd64.tar.gz && \
    dpkg -i emane-0.9.2-release-1/debs/ubuntu-14_04/amd64/emane*.deb && \
    rm -rf emane-0.9.2-release-1

RUN mkdir ~/.vnc
RUN x11vnc -storepasswd coreemu ~/.vnc/passwd
ADD startCore.sh startCore.sh

EXPOSE 5900
CMD ["/bin/bash", "/startCore.sh"]
