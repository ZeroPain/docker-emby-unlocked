#!/bin/bash

# exit script if return code != 0
set -e

# define pacman packages
pacman_packages="unzip unrar librsvg pygtk python2-service-identity python2-mako python2-notify deluge"

# install pre-reqs
pacman -Syu --ignore filesystem --noconfirm
pacman -S --needed $pacman_packages --noconfirm

# set permissions
chown -R nobody:users /usr/bin/deluged /usr/bin/deluge-web
chmod -R 775 /usr/bin/deluged /usr/bin/deluge-web

# add in temporary fixes for torrents stuck in paused mode
curl -o /tmp/libtorrent-rasterbar.tar.xz -L http://ala.seblu.net/packages/l/libtorrent-rasterbar/libtorrent-rasterbar-1%3A1.0.7-2-x86_64.pkg.tar.xz
pacman -U /tmp/libtorrent-rasterbar.tar.xz --noconfirm

curl -o /tmp/boost-libs.tar.xz -L http://ala.seblu.net/packages/b/boost-libs/boost-libs-1.59.0-5-x86_64.pkg.tar.xz
pacman -U /tmp/boost-libs.tar.xz --noconfirm

curl -o /tmp/boost.tar.xz -L http://ala.seblu.net/packages/b/boost/boost-1.59.0-5-x86_64.pkg.tar.xz
pacman -U /tmp/boost.tar.xz --noconfirm

# cleanup
yes|pacman -Scc
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /tmp/*
