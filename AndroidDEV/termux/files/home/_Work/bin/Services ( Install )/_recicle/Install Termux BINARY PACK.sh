#!/system/bin/sh
clear
path=$( cd "${0%/*}" && pwd -P )


/system/bin/busybox mount -o remount,rw /
/system/bin/busybox mount -o remount,rw /system

# descompactar
cd /
tar -xvf "$path/TermuxBinPacks.tar.gz"


# /system/bin/busybox mount -o remount,rw /system

# # bins-B.002.0-armeabi-v7a-termuxLibs.7z
# ln -sf /system/usr/lib/p7zip/7za /system/bin/7z
# ln -sf /system/usr/lib/p7zip/7za /system/bin/7z.so
# 	# esta é a lib para o firmware antigo
# ln -sf /system/usr/lib/libz.so.1.2.11 /system/lib/libz.so.1
# # bash
# ln -sf /system/usr/bin/bash /system/bin/bash
# # curl
# ln -sf /system/usr/bin/curl /system/bin/curl
# # lighttpd
# ln -sf /system/usr/bin/lighttpd /system/bin/lighttpd
# # php
# ln -sf /system/usr/bin/php-cgi /system/bin/php-cgi
# # rsync
# ln -sf /system/usr/bin/rsync /system/bin/rsync
# ln -sf /system/usr/bin/rsync-ssl /system/bin/rsync-ssl
# # screen
# ln -sf /system/usr/bin/screen /system/bin/screen
# # transmission
# ln -sf /system/usr/bin/transmission-create /system/bin/
# ln -sf /system/usr/bin/transmission-remote /system/bin/
# ln -sf /system/usr/bin/transmission-edit /system/bin/
# ln -sf /system/usr/bin/transmission-show /system/bin/
# ln -sf /system/usr/bin/transmission-daemon /system/bin/
# # wget
# ln -sf /system/usr/bin/wget /system/bin/
# # diskutills
# ln -sf /system/usr/bin/wget /system/bin/
# ln -sf /system/usr/bin/fdisk /system/bin/
# ln -sf /system/usr/bin/gdisk /system/bin/
# ln -sf /system/usr/bin/mkfs.ext4 /system/bin/
# ln -sf /system/usr/bin/parted /system/bin/

