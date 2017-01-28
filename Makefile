#
CUR_PATH=	$(shell pwd)
NOW=		$(shell date -u +%Y%m%d-%H%m%S)
USER_GID=	$(shell id -g)
USER_UID=	$(shell id -u)

#
build:
	docker build -t "gslin/rtorrent:${NOW}" .
	docker tag "gslin/rtorrent:${NOW}" gslin/rtorrent:latest

run:
	docker run -e USER_GID="${USER_GID}" -e USER_UID="${USER_UID}" -i -p 6991 -t -v "${CUR_PATH}:/srv/rtorrent" gslin/rtorrent:latest
