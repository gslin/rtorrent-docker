#!/bin/bash

if [[ "x${USER_UID}" = x ]]; then
    echo "USER_UID is empty."
    exit 1
fi

if [[ "x${USER_GID}" = x ]]; then
    echo "USER_GID is empty."
    exit 1
fi

useradd -d /home/rtorrent -g "${USER_GID}" -m -s /bin/bash -u "${USER_UID}" rtorrent

su - rtorrent -c "cd /srv/rtorrent; mkdir -p session; rtorrent"
