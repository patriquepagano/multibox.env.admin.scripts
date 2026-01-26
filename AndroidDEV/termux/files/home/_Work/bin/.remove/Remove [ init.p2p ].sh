#!/system/bin/sh

/system/bin/busybox mount -o remount,rw /system
rm /system/etc/init/init.p2p.rc
rm /system/bin/init.p2p.sh
