#!/system/bin/sh


while [ 1 ]; do
	instance=`/system/bin/busybox ps aux | grep "com.termux/files/usr/bin/sshd" | /system/bin/busybox grep -v grep | awk '{print $1}'`
	if [ ! "$instance" == "" ]; then
		echo "ADM DEBUG ### fechando o processo $instance"
		busybox kill -9 $instance
	else
		break
	fi
done

busybox mount -o remount,rw /system
echo "98d7y09yadsioufyaisdfyiouads" > /system/.pin

busybox chown 1023:1023 -R /data/data/com.termux/files
rm -rf /data/data/com.termux

FolderPath="/storage/DevMount"
busybox umount $FolderPath > /dev/null 2>&1


while [ 1 ]; do
	instance=`/system/bin/busybox ps aux | grep "AdminDevMount.sh" | /system/bin/busybox grep -v grep | awk '{print $1}'`
	if [ ! "$instance" == "" ]; then
		echo "ADM DEBUG ### fechando o processo $instance"
		busybox kill -9 $instance
	else
		break
	fi
done



