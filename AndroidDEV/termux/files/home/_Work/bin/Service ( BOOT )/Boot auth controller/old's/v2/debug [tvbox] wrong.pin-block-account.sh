#!/system/bin/sh

/system/bin/busybox mount -o remount,rw /system
echo "123-pin-errado-simulate-cloning" > /system/Pin

