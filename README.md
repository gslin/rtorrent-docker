rtorrent-docker
===============

Running [rTorrent](https://github.com/rakshasa/rtorrent) in a [Docker](https://www.docker.com/) container for isolation, based on Ubuntu 22.04 and self-compiled rtorrent.

This package also has implemented two workarounds for the [hanging bug](https://github.com/rakshasa/rtorrent/issues/180), one is running dnsmasq, another one is use of libudns.

Command
-------

If you don't specify `BT_PORT` then it will be 6991 by default.

    docker run --rm -e PORT=6991 -e TERM=${TERM} -e USER_GID=`id -g` -e USER_UID=`id -u` \
        -i -p 6991:6991 -t -v "`pwd`:/srv/rtorrent" gslin/rtorrent:latest
