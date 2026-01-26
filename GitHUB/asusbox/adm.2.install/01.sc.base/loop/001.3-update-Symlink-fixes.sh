
# symlink muito utilizado em especial para o php
CheckSymlink=`/system/bin/busybox readlink -fn /system/lib/libz.so.1`
if [ ! "$CheckSymlink" == "/system/usr/lib/libz.so.1.2.11" ] ; then
    /system/bin/busybox mount -o remount,rw /system
    /system/bin/busybox ln -sf /system/usr/lib/libz.so.1.2.11 /system/lib/libz.so.1
fi



