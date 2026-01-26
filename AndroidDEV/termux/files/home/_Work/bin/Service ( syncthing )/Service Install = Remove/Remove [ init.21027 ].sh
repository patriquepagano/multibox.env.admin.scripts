#!/system/bin/sh
clear
path=$( cd "${0%/*}" && pwd -P )
toolx="/system/bin/busybox"

setprop ctl.stop init21027

/system/bin/busybox mount -o remount,rw /system
rm /system/etc/init/init.21027.rc
rm /system/bin/init.21027.sh

while [ 1 ]; do
	instance=`$toolx ps aux | $toolx grep "init.21027.sh" | $toolx grep -v grep | $toolx head -n 1 | $toolx awk '{print $1}'`
	if [ ! "$instance" == "" ]; then
		echo "ADM DEBUG ### fechando o processo $instance"
		$toolx kill -9 $instance
	else
		break
	fi
done

cat /system/bin/init.21027.sh


info

read bah