#
FROM ubuntu:xenial-20170119
MAINTAINER gslin@gslin.org

#
RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common && \
    apt-add-repository -y ppa:crass/libtorrent && \
    apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y rtorrent && \
    apt-get clean

COPY .rtorrent.rc /home/rtorrent/.rtorrent.rc
COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 644 /home/rtorrent/.rtorrent.rc && \
    chmod 755 /sbin/entrypoint.sh

EXPOSE 6991

ENTRYPOINT ["/sbin/entrypoint.sh"]
