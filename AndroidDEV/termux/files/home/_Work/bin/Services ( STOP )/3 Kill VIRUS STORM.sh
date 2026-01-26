#!/system/bin/sh


checkPort=`/system/bin/busybox pidof storm`
if [ ! "$checkPort" == "" ];then
    /system/bin/busybox kill $checkPort
    echo "ADM DEBUG ### virus rodando na porta $checkPort"
    /system/bin/busybox mount -o remount,rw /system
    rm /system/bin/storm
    rm /system/bin/install-recovery.sh
    rm /system/etc/init/storm.rc
    rm /system/etc/storm.key
    echo "NO!" > /system/bin/storm
    busybox chmod 400 /system/bin/storm
    du -h /system/bin/storm
fi




# exit
if [ -f /system/bin/storm ]; then
echo "virus encontrado deletando"
checkPort=`/system/bin/busybox pidof storm`
/system/bin/busybox kill $checkPort
echo "ADM DEBUG ### virus rodando na porta $checkPort"
/system/bin/busybox mount -o remount,rw /system
rm /system/bin/storm
rm /system/bin/install-recovery.sh
rm /system/etc/init/storm.rc
rm /system/etc/storm.key
du -h /system/bin/storm
fi


