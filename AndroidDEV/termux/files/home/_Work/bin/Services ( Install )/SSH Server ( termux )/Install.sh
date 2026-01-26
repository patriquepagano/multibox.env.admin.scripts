#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )
cd "$path"

OldFile=`cat /system/bin/AdminDevMount.sh`
NewFile=`cat "AdminDevMount.sh"`

if [ ! "$OldFile" == "$NewFile" ]; then
	/system/bin/busybox mount -o remount,rw /system
	echo "Novo sistema"
	cat "AdminDevMount.rc" > /system/etc/init/AdminDevMount.rc
	chmod 0644 /system/etc/init/AdminDevMount.rc
	cat "AdminDevMount.sh" > /system/bin/AdminDevMount.sh
	chmod 0755 /system/bin/AdminDevMount.sh
	cat /system/bin/AdminDevMount.sh
else
	echo "Dont need update file > AdminDevMount.sh"
fi
