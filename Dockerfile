# syntax=docker/dockerfile:1.3-labs
#
FROM debian:bullseye-20230522-slim
MAINTAINER gslin@gslin.org

#
RUN <<EOF bash
  apt update -y
  apt install -y autoconf build-essential dnsmasq git libcurl4-openssl-dev libssl-dev libtool libncursesw5-dev libudns-dev locales pkg-config sudo zlib1g-dev
  apt clean
  cd ~
  git clone https://github.com/rakshasa/libtorrent.git
  cd libtorrent
  git checkout slingamn-udns.10
  autoreconf -fi
  ./configure --prefix=/usr --with-udns
  make -j
  make install
  cd ~
  git clone https://github.com/rakshasa/rtorrent.git
  cd rtorrent
  git checkout 582e4e40256b43d3e5322168f1e1ed71ca70ab64
  autoreconf -fi
  ./configure --prefix=/usr
  make -j
  make install
  apt purge -y autoconf build-essential git libcurl4-openssl-dev libssl-dev libtool libncursesw5-dev libudns-dev pkg-config zlib1g-dev
  locale-gen en_US.UTF-8
EOF

COPY .rtorrent.rc.template /home/rtorrent/.rtorrent.rc.template
COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 6991

ENTRYPOINT ["/sbin/entrypoint.sh"]
