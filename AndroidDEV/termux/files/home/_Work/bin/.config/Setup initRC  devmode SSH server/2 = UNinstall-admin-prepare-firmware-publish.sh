#!/system/bin/sh
set -x

/system/bin/busybox mount -o remount,rw /system

# # limpando os antigos
rm /system/etc/init/AdminDevMount.rc
rm /system/bin/AdminDevMount.sh

rm /system/etc/init/initRc.adm.drv.rc
rm /system/bin/initRc.adm.drv.sh

rm /system/android_id
rm /system/UUID




