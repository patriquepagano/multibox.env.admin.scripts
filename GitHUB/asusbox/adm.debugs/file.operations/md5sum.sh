#!/system/bin/sh

clear

date
list="/system/bin/7z
/system/bin/busybox
/system/bin/aria2c
/system/bin/transmission-remote
/system/bin/curl
/system/bin/rsync
/system/bin/wget
/system/bin/lighttpd
/system/bin/php-cgi
/system/xbin/su
"
for loop in $list; do
    crc=`/system/bin/busybox md5sum "$loop" | cut -d ' ' -f1 #>> /data/tmp.hash 2>&1`
    echo "$crc >>> $loop"    
done
date



