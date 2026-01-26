#!/system/bin/sh

for i in $appRemove; do
busybox mount -o remount,rw /system
	app=`echo $i | cut -d "/" -f 2 | cut -d "=" -f 2 | sed -e 's/.apk//g'`
	data=`echo $i | cut -d "=" -f 1`
	if [ -e /system/priv-app/$app ] ; then
		chmod 777 -R /system/app/$app
		echo 'Removendo ' $app
		pm disable $data
		rm -rf /system/priv-app/$app
		echo 'Removendo ' $data
		rm -rf /data/data/$data
		rm -rf /data/app-lib/$data
		sleep 2
	fi
	if [ -e /system/priv-app/$app.apk ] ; then
		chmod 777 -R /system/app/$app
		echo 'Removendo ' $app
		pm disable $data
		rm -rf /system/priv-app/$app.apk
		rm -rf /system/priv-app/$app.odex
		echo 'Removendo ' $data
		rm -rf /data/data/$data
		rm -rf /data/app-lib/$data
		sleep 2
	fi
	clear
done

