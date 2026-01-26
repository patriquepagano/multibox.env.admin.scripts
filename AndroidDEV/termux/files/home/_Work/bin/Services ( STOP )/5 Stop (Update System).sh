#!/system/bin/sh


/system/bin/busybox ps aux | grep UpdateSystem.sh | /system/bin/busybox grep -v grep

KillApp=`/system/bin/busybox ps aux | grep UpdateSystem.sh | /system/bin/busybox grep -v grep | awk '{print $1}'`
if [ "$KillApp" == "" ]; then
    echo "Update system dont running"
else
    /system/bin/busybox kill -9 $KillApp
fi



