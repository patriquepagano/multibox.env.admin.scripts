#!/data/data/com.termux/files/usr/bin/env /data/data/com.termux/files/usr/bin/bash
#

echo "Desligando transmission torrent downloader"
/system/bin/transmission-remote --exit
killall transmission-daemon

/system/bin/busybox mount -o remount,rw /system

rm -rf /system/bin/transmission-create
rm -rf /system/bin/transmission-daemon
rm -rf /system/bin/transmission-edit
rm -rf /system/bin/transmission-remote
rm -rf /system/bin/transmission-show
rm -rf /system/lib/libminiupnpc.so
rm -rf /system/lib/libcrypto.so.1.1
rm -rf /system/lib/libcurl.so
rm -rf /system/lib/libevent-2.1.so
rm -rf /system/lib/libnghttp2.so
rm -rf /system/lib/libssl.so.1.1
rm -rf /system/lib/libz.so.1
rm -rf /system/usr/share/transmission

