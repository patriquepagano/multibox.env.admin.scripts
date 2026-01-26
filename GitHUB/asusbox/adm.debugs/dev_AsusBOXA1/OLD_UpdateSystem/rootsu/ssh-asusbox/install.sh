#!/system/bin/sh

/system/bin/busybox mount -o remount,rw /system

cp ${0%/*}/rootsudaemon.sh /system/bin/rootsudaemon.sh

cat /system/bin/rootsudaemon.sh

chmod 755 /system/bin/rootsudaemon.sh



