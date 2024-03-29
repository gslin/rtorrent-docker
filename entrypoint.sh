#!/bin/bash

BT_PORT=${PORT:-6991}

if [[ "x${USER_GID}" = x ]]; then
    echo "USER_GID is empty."
    exit 1
else
    groupadd -f -g "${USER_GID}" rtorrent
fi

if [[ "x${USER_UID}" = x ]]; then
    echo "USER_UID is empty."
    exit 1
else
    useradd -d /home/rtorrent -g "${USER_GID}" -m -s /bin/bash -u "${USER_UID}" rtorrent
fi

service dnsmasq start
echo "nameserver 127.0.0.1" > /etc/resolv.conf

cd ~rtorrent
sed -e "s/BT_PORT/${BT_PORT}/g" .rtorrent.rc.template > .rtorrent.rc
chmod 644 .rtorrent.rc

mkdir -p session
chown rtorrent:rtorrent session

sudo -i -u rtorrent -- bash -c "cd /srv/rtorrent; LANG=en_US.UTF-8 rtorrent"
