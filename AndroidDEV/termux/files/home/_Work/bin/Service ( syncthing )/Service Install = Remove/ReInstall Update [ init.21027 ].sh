#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
BB="/system/bin/busybox"

setprop ctl.stop init21027

/system/bin/busybox mount -o remount,rw /system
rm /system/etc/init/init.21027.rc > /dev/null 2>&1
rm /system/bin/init.21027.sh > /dev/null 2>&1

echo "Novo sistema"

cat "$path/init.21027.rc" > /system/etc/init/init.21027.rc
chmod 0644 /system/etc/init/init.21027.rc

cat "$path/init.21027.SH" > /system/bin/init.21027.sh
chmod 0755 /system/bin/init.21027.sh

# quem iniciar este service é o init.boot atualmente
#setprop ctl.start init21027
#/system/bin/init.21027.sh &

if [ ! "$1" == "skip" ]; then
    echo "Press enter to continue."
    read bah
fi

