#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear


echo "
### blkid"
busybox blkid
echo "
### mounted public"
busybox mount | grep public
echo "
### mounted manual"
busybox mount | grep "/storage/DevMount"
busybox mount | grep "/storage/MultiBOX"
