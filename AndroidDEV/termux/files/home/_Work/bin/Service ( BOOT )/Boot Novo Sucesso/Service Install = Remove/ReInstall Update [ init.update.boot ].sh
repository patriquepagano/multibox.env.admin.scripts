#!/system/bin/sh
path="$( cd "${0%/*}" && pwd -P )"
clear

setprop ctl.stop InitUpdateBoot

/system/bin/busybox mount -o remount,rw /system
rm /system/etc/init/init.update.boot.rc > /dev/null 2>&1
rm /system/bin/init.update.boot.sh > /dev/null 2>&1

echo "Novo sistema"

cat "$path/init.update.boot.rc" > /system/etc/init/init.update.boot.rc
chmod 0644 /system/etc/init/init.update.boot.rc

cat "$path/init.update.boot.SH" > /system/bin/init.update.boot.sh
chmod 0755 /system/bin/init.update.boot.sh

setprop ctl.start InitUpdateBoot


/system/bin/init.update.boot.sh &



if [ ! "$1" == "skip" ]; then
    echo "Press enter to continue."
    read bah
fi

