#!/system/bin/sh

set -x

/system/bin/busybox mount -o remount,rw /system

cat ${0%/*}/init.d.rc > /system/etc/init/init.d.rc
chmod 0644 /system/etc/init/init.d.rc
cat ${0%/*}/init.d.sh > /system/bin/init.d.sh
chmod 0755 /system/bin/init.d.sh


cat /system/bin/init.d.sh


