#!/system/bin/sh

# Dir=$(dirname $0)
# echo $Dir

checkLink=`/system/bin/busybox readlink -f /system/etc/hosts`
if [ ! "$checkLink" == "/data/asusbox/.sc/OnLine/sys/hostsList" ]; then
    echo "ADM DEBUG ######################################################"
    echo "ADM DEBUG ### Atualizando symlink do hosts"
    /system/bin/busybox mount -o remount,rw /system
    rm /system/etc/hosts
    /system/bin/busybox ln -sf /data/asusbox/.sc/OnLine/sys/hostsList /system/etc/hosts
fi


