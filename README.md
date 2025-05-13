# 使用說明

## 產生 docker image

- Debian 版本

```
#
KERNEL_LEVEL=`uname -a | awk '{print $3}' | sed 's;-[a-z]..*$;;'`
ZFS_VER=2.3.2
docker build --build-arg KERNEL_LEVEL=$KERNEL_LEVEL --build-arg ZFS_VER=$ZFS_VER -f ./Dockerfile-debian -t gilgal/buildzfs:$KERNEL_LEVEL .
docker tag gilgal/buildzfs:$KERNEL_LEVEL gilgal/buildzfs
```

## 產生 deb 檔

因想自行編譯 OpenZFS 使用, 且只在熟悉的 Debian, ubuntu 上製作 deb 安裝檔

需調整 build.sh 裡 ZFS_VER 變數, 用於下載對應的 openzfs 版本

再執行 sh build.sh 就行

# 執行步驟說明

1. 至 https://github.com/openzfs/zfs 下載最新版本
2. 建立 deb 目錄, bind mount 至 container 裡儲存編譯完成的 deb 安裝檔

