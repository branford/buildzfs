#!/bin/sh
ZFS_VER=`curl https://github.com/openzfs/zfs/releases 2>/dev/null | grep 'h2 class="sr-only"' | grep 'zfs-' | head -1 | sed 's;^..*zfs-\([^<][^<]*\)</..*;\1;'`
LAST=`cat .cur`

if [ "$ZFS_VER" = "$LAST" ]; then
    echo "A newer version of OpenZFS is required to build .deb packages for Debian."
    exit
fi

# 移除舊的 docker image
for i in `docker images | grep buildzfs | awk '{print $2}'`
do
    docker rmi gilgal/buildzfs:$i
done

# 取得 host linux kernel 版本, 目前只支援 x86 架構
# 會將 6.1.03-amd64 轉成 6.1.03
OSDIST=`grep '^ID=' /etc/os-release | sed 's;..*=;;'`
if [ "$OSDIST" = 'debian' ]; then
    KERNEL_LEVEL=`uname -r | sed 's;-am..*;;'`
    DOCKERFILE='Dockerfile-debian'
elif [ "$OSDIST" = 'ubuntu' ]; then
    KERNEL_LEVEL=`uname -r | sed 's;-ge..*;;'`
    DOCKERFILE='Dockerfile-ubuntu'
else
    echo "We only build container images for Debian or Ubuntu."
    exit
fi

if [ $# -eq 0 ]; then
    DOCKERRUN="docker run --rm -v ./deb:/deb gilgal/buildzfs"
elif [ "$1" = 'deb' ]; then
    DOCKERRUN="docker run --rm -v ./deb:/deb gilgal/buildzfs"
elif [ "$1" = 'native' ]; then
    DOCKERRUN="docker run --rm -e MAKEENV=native -v ./deb:/deb gilgal/buildzfs"
else
    echo "Exactly one parameter must be specified—either 'deb' or 'native.' Please verify."
    exit
fi

if [ -z "`docker images | grep 'gilgal/buildzfs'`" ]; then
    TAG="$KERNEL_LEVEL-$ZFS_VER"
    docker build --build-arg KERNEL_LEVEL=$KERNEL_LEVEL --build-arg ZFS_VER=$ZFS_VER -f $DOCKERFILE -t gilgal/buildzfs:$TAG .
    docker tag gilgal/buildzfs:$TAG gilgal/buildzfs
    echo "[1;31m完成 docker image 建置[0m"
fi

if [ ! -e deb ]; then
    mkdir deb
    chown -R 1000000:1000000 deb
fi

eval "$DOCKERRUN"

echo $ZFS_VER > .cur
