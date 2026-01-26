#!/system/bin/sh


/system/bin/busybox mount -o remount,rw /system
rm /system/etc/init/init.80.900x.rc
rm /system/bin/init.80.900x.sh

