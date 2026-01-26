#!/system/bin/sh
clear
# echo "# arguments called with ---->  ${@}     "
# echo "# \$1 ---------------------->  $1       "
# echo "# \$2 ---------------------->  $2       "
# echo "# path to me --------------->  ${0}     "
# echo "# parent path -------------->  ${0%/*}  "
# echo "# my name ------------------>  ${0##*/} "
export CPU=`getprop ro.product.cpu.abi`


function extractFiles () {
#### descompactando os arquivos
/system/bin/busybox find /storage/DevMount/AndroidDEV/bins/$CPU -maxdepth 1 -type f \( -iname \*.tar.gz \) | /system/bin/busybox sort | while read fname; do
    echo "$fname"
    /system/bin/busybox mount -o remount,rw /system
    # descompactar
    cd /
    /system/bin/busybox tar -xvf "$fname"
done

}

function CheckSymlinks () {
/system/bin/busybox readlink -v /system/bin/bash

}

function Symlinks () {
# set rw
/system/bin/busybox mount -o remount,rw /system
# # bash
if [ -f /system/usr/bin/bash ];then
    ln -sf /system/usr/bin/bash /system/bin/bash
fi
# curl
if [ -f /system/usr/bin/curl ];then
    ln -sf /system/usr/bin/curl /system/bin/curl
fi
# lighttpd
if [ -f /system/usr/bin/lighttpd ];then
    ln -sf /system/usr/bin/lighttpd /system/bin/lighttpd
fi
# nodejs
if [ -f /system/usr/bin/node ];then
    ln -sf /system/usr/bin/node /system/bin/node
fi
# php-cgi
if [ -f /system/usr/bin/php-cgi ];then
    ln -sf /system/usr/bin/php-cgi /system/bin/php-cgi
fi
# php-fpm
if [ -f /system/usr/bin/php-fpm ];then
    ln -sf /system/usr/bin/php-fpm /system/bin/php-fpm
fi
# rsync
if [ -f /system/usr/bin/rsync ];then
ln -sf /system/usr/bin/rsync /system/bin/rsync
fi
# screen
if [ -f /system/usr/bin/screen-4.8.0 ];then
    ln -sf /system/usr/bin/screen-4.8.0 /system/bin/screen
fi
# Transmission
if [ -f /system/usr/bin/transmission-create ];then
    ln -sf /system/usr/bin/transmission-create /system/bin/
    ln -sf /system/usr/bin/transmission-remote /system/bin/
    ln -sf /system/usr/bin/transmission-edit /system/bin/
    ln -sf /system/usr/bin/transmission-show /system/bin/
    ln -sf /system/usr/bin/transmission-daemon /system/bin/
fi
# wget
if [ -f /system/usr/bin/wget ];then
    ln -sf /system/usr/bin/wget /system/bin/wget
fi
# esta versao de 7za que descomprime multi-volumes
if [ -f /system/usr/lib/p7zip/7za ];then
    ln -sf /system/usr/lib/p7zip/7za /system/bin/7z
    ln -sf /system/usr/lib/p7zip/7za /system/bin/7z.so # para apagar do firmware antigo este binario é grande
fi

}


extractFiles

Symlinks


