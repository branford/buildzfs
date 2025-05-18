# README for buildzfs

## Supported Linux Distributions

- Debian 12  
- Ubuntu 22.04

You can use this project to build OpenZFS `.deb` packages for Debian 12 or Ubuntu 22.04.

## How to Use

```bash
cd /srv
git clone https://github.com/branford/buildzfs.git
cd buildzfs
sh build.sh
```

## How to Install and Use

The generated `.deb` files will be located in the `/srv/buildzfs/deb` directory.  
For example, for OpenZFS version 2.3.2:

```
# Debian 12
kmod-zfs-6.1.0-34-amd64_2.3.2-1_amd64.deb  
libnvpair3_2.3.2-1_amd64.deb  
libuutil3_2.3.2-1_amd64.deb  
libzfs6_2.3.2-1_amd64.deb  
libzpool6_2.3.2-1_amd64.deb  
pam-zfs-key_2.3.2-1_amd64.deb  
zfs_2.3.2-1_amd64.deb  
zfs-dkms_2.3.2-1_amd64.deb  
zfs-dracut_2.3.2-1_amd64.deb  
zfs-initramfs_2.3.2-1_amd64.deb  
zfs-test_2.3.2-1_amd64.deb  
```

You can install the packages using `dpkg -i` in the following order:

```bash
dpkg -i kmod-zfs-6.1.0-34-amd64_2.3.2-1_amd64.deb
dpkg -i libuutil3_2.3.2-1_amd64.deb
dpkg -i libzfs6_2.3.2-1_amd64.deb
dpkg -i libzpool6_2.3.2-1_amd64.deb
dpkg -i zfs_2.3.2-1_amd64.deb
dpkg -i zfs-dkms_2.3.2-1_amd64.deb
dpkg -i zfs-initramfs_2.3.2-1_amd64.deb
dpkg -i libnvpair3_2.3.2-1_amd64.deb
dpkg -i zfs-dracut_2.3.2-1_amd64.deb
```

