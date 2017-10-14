#
FROM ubuntu:xenial-20171006
MAINTAINER gslin@gslin.org

#
RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y locales software-properties-common sudo && \
    apt-add-repository -y ppa:crass/libtorrent && \
    apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y rtorrent && \
    apt-get clean && \
    locale-gen en_US.UTF-8

COPY .rtorrent.rc.template /home/rtorrent/.rtorrent.rc.template
COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 6991

ENTRYPOINT ["/sbin/entrypoint.sh"]
