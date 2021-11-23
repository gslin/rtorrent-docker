# syntax=docker/dockerfile:1.3-labs
#
FROM ubuntu:jammy-20211029
MAINTAINER gslin@gslin.org

#
RUN <<EOF bash
  apt update -y
  DEBIAN_FRONTEND=noninteractive apt install -y locales rtorrent sudo
  apt clean
  locale-gen en_US.UTF-8
EOF

COPY .rtorrent.rc.template /home/rtorrent/.rtorrent.rc.template
COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 6991

ENTRYPOINT ["/sbin/entrypoint.sh"]
