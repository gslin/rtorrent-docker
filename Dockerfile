#
FROM ubuntu:xenial-20190425
MAINTAINER gslin@gslin.org

#
RUN apt update -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y locales software-properties-common sudo && \
    apt-add-repository -y ppa:crass/libtorrent && \
    apt update -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y rtorrent && \
    apt clean && \
    locale-gen en_US.UTF-8

COPY .rtorrent.rc.template /home/rtorrent/.rtorrent.rc.template
COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 6991

ENTRYPOINT ["/sbin/entrypoint.sh"]
