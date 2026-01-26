#!/system/bin/sh


/system/bin/busybox mount -o remount,rw /system
rm /system/etc/init/initRc.drv.01.01.97.rc

echo "removendo o bloqueio de acesso root a os apps"
rm /system/.pin


