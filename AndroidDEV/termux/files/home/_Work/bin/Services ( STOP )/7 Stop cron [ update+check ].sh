#!/system/bin/sh

while true
do
    echo "ADM DEBUG ########################################################"
    killPort=`/system/bin/busybox ps aux | grep update+check.sh | /system/bin/busybox grep -v grep | awk '{print $1}'`    
    echo "ADM DEBUG ### porta ativa no update+check > $killPort "
	if [ ! "$killPort" == "" ]; then
        echo "ADM DEBUG ### close update+check > $killPort"
        /system/bin/busybox kill -9 $killPort
        logcat -c
    else
        break
    fi
done




