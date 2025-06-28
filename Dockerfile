# syntax=docker/dockerfile:1.3-labs
#
FROM debian:bookworm-20250610
MAINTAINER gslin@gslin.org

#
RUN <<EOF bash
  apt update -y
  apt install -y autoconf build-essential git libcurl4-openssl-dev libssl-dev libtool libncursesw5-dev locales pkg-config sudo zlib1g-dev
  apt clean
  cd ~
  git clone https://github.com/rakshasa/libtorrent.git
  cd libtorrent
  git checkout v0.15.5
  autoreconf -fi
  ./configure --prefix=/usr
  make -j8
  make install
  cd ~
  git clone https://github.com/rakshasa/rtorrent.git
  cd rtorrent
  git checkout v0.15.5
  autoreconf -fi
  ./configure --prefix=/usr
  make -j8
  make install
  apt purge -y autoconf build-essential git libcurl4-openssl-dev libssl-dev libtool libncursesw5-dev libudns-dev pkg-config zlib1g-dev
  rm -rf libtorrent rtorrent
  sed -i 's/^# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
  locale-gen en_US.UTF-8
EOF

COPY .rtorrent.rc.template /home/rtorrent/.rtorrent.rc.template
COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 6991

ENTRYPOINT ["/sbin/entrypoint.sh"]
