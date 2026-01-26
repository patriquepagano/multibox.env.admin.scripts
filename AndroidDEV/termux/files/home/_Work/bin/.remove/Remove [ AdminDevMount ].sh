#!/system/bin/sh

	/system/bin/busybox mount -o remount,rw /system
	rm /system/etc/init/AdminDevMount.rc
	rm /system/bin/AdminDevMount.sh


