#!/system/bin/sh

	/system/bin/busybox mount -o remount,rw /system
	rm /system/etc/init/init.update.boot.rc
	rm /system/bin/init.update.boot.sh
