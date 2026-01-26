#!/system/bin/sh

/system/bin/busybox mount -o remount,rw /system

echo "limpando sistema antigo, preciso disto para criar uma regra de exclusão no firmware"

/system/bin/busybox cat "${0%/*}/initRc.adm.drv.rc" > /system/etc/init/initRc.adm.drv.rc
/system/bin/busybox cat "${0%/*}/initRc.adm.drv.sh" > /system/bin/initRc.adm.drv.sh

/system/bin/busybox chmod 644 /system/etc/init/initRc.adm.drv.rc
/system/bin/busybox chmod 755 /system/bin/initRc.adm.drv.sh

# # limpando os antigos
rm /system/etc/init/AdminDevMount.rc
rm /system/bin/AdminDevMount.sh

cat /system/bin/initRc.adm.drv.sh




