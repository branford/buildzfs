#!/bin/sh
BASEDIR='/srv/src'
DEBDIR='/deb'
if [ ! -e "$BASEDIR/configure" ]; then
    echo "please download openzfs first"
    exit
fi

if [ "$MAKEENV" = 'deb' ]; then
    MKCMD="make deb"
elif [ "$MAKEENV" = 'native' ]; then
    MKCMD="make native-deb-utils"
else
    echo "[1;31mwe cant not build deb files[0m"
    exit
fi

cd $BASEDIR
./autogen.sh

# https://github.com/openzfs/zfs/issues/16155
# RPM build errors:
#    File not found: /tmp/zfs-build-root-A9VcYovo/BUILDROOT/zfs-2.2.4-1.x86_64/usr/lib/python3/dist-packages/libzfs_core/*
#    File not found: /tmp/zfs-build-root-A9VcYovo/BUILDROOT/zfs-2.2.4-1.x86_64/usr/lib/python3/dist-packages/pyzfs*
# workaround: --enable-pyzfs=no
./configure --enable-pyzfs=no

echo "[1;31m正在編譯 openZFS[0m"
# https://bugs.launchpad.net/ubuntu/+source/cpio/+bug/2066157
eval "$MKCMD"

echo
echo "[1;31m編譯完成[0m"
echo
sleep 5

if [ "$MAKEENV" = 'deb' ]; then
    mv *.deb /deb
    rm -f /deb/*devel*
elif [ "$MAKEENV" = 'native' ]; then
    cd /srv
    mv *.deb /deb
    rm -f /deb/*dbgsym*
else
    echo "[1;31mwe have some error. please check![0m"
    exit
fi

echo
echo "[1;31m作業完成[0m"
echo

