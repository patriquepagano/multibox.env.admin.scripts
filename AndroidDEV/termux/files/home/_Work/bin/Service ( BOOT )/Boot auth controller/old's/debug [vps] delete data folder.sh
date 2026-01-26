#!/system/bin/sh

clear
# input vindo do secretAPI do firmware

#IPTest="http://137.184.131.95"
#curl -w "%{http_code}" "$IPTest/debug-delete-dataFolder.php"


IPTest="http://10.0.0.91:777"
curl "$IPTest/debug-delete-dataFolder.php"


echo "
deletando serial na box
"
/system/bin/busybox mount -o remount,rw /system
rm /data/Serial



