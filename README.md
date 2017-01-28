Running [rTorrent](https://github.com/rakshasa/rtorrent) in [Docker](https://www.docker.com/) container.

Command
=======

    docker run -e USER_GID=`id -g` -e USER_UID=`id -g` -i -p 6991 -t -v "`pwd`:/srv/rtorrent" gslin/rtorrent:latest
