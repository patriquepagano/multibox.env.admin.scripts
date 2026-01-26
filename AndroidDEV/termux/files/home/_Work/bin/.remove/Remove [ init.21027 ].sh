#!/system/bin/sh


/system/bin/busybox mount -o remount,rw /system
rm /system/etc/init/init.21027.rc
rm /system/bin/init.21027.sh
