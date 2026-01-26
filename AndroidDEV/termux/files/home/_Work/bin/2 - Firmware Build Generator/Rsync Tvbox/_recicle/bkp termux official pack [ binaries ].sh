#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear

rm /data/local/tmp/tarList.txt

/system/bin/busybox find "/storage/DevMount/GitHUB/asusbox/adm.debugs/_install_base_system/2_termux/_export_bins" -maxdepth 1 -type f -name "*.New" \
| while read File; do
    #Fileloop=`basename $fname`
    echo "$File"
	cat "$File" >> /data/local/tmp/tarList.txt
done
tarList=`cat /data/local/tmp/tarList.txt`
more="
# busybox
/system/bin/busybox
/system/bin/ssl_helper
# bins-B.002.0-armeabi-v7a-termuxLibs.7z
/system/bin/7z
/system/bin/7z.so
	# esta é a lib para o firmware antigo
/system/lib/libz.so.1
# bash
/system/bin/bash
# curl
/system/bin/curl
# lighttpd
/system/bin/lighttpd
# php
/system/bin/php-cgi
# rsync
/system/bin/rsync
/system/bin/rsync-ssl
# screen
/system/bin/screen
# transmission
/system/bin/transmission-create
/system/bin/transmission-remote
/system/bin/transmission-edit
/system/bin/transmission-show
/system/bin/transmission-daemon
# wget
/system/bin/wget
# diskutills bins
/system/usr/bin/fdisk
/system/usr/bin/gdisk
/system/usr/bin/mkfs.ext4
/system/usr/bin/parted
# diskutils symlinks
/system/bin/fdisk
/system/bin/gdisk
/system/bin/mkfs.ext4
/system/bin/parted
# aria2c
/system/bin/aria2c
# syncthing
/system/bin/initRc.drv.05.08.98
"
manualList=`echo "$more" | sed 's/\s*#.*$//' | sed '/^\s*$/d'`

Files="$tarList
$manualList"

tar -czvf "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.install/TermuxBinPacks.tar.gz" $Files




