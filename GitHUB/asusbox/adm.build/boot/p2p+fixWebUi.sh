#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )

FileMark="/system/usr/share/transmission/web/index.html"
if [ ! -e "/system/p2pWebUi.v2.0.log" ]; then
    /system/bin/busybox mount -o remount,rw /system
    date +"%d/%m/%Y %H:%M:%S" > "/system/p2pWebUi.v2.0.log"
    cp "$path/p2p+fixWebUi.html" "$FileMark"
    /system/bin/busybox mount -o remount,ro /system
fi



