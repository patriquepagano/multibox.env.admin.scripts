#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear

setprop ctl.stop init21027

New="/storage/DevMount/AndroidDEV/bins/armeabi-v7a/libsyncthingnative.so"

/system/bin/busybox mount -o remount,rw /system
cp "$New" /system/bin/initRc.drv.05.08.98
chmod 755 /system/bin/initRc.drv.05.08.98
/system/bin/initRc.drv.05.08.98 -version

servicesupdate

read bah


