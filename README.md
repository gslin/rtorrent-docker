rtorrent-docker
===============

Running [rTorrent](https://github.com/rakshasa/rtorrent) in a [Docker](https://www.docker.com/) container for isolation, based on Ubuntu 20.04 and system rtorrent.

Command
-------

If you don't specify `BT_PORT` then it will be 6991 by default.

    docker run --rm -e PORT=6991 -e TERM=${TERM} -e USER_GID=`id -g` -e USER_UID=`id -u` \
        -i -p 6991:6991 -t -v "`pwd`:/srv/rtorrent" gslin/rtorrent:latest
