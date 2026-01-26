#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )

OldFile=`cat /system/bin/init.80.900x.sh`
NewFile=`cat "$path/init.80.900x.sh"`

if [ ! "$OldFile" == "$NewFile" ]; then
	/system/bin/busybox mount -o remount,rw /system
	# echo "limpando sistema antigo"

	# file="/system/bin/rootsudaemon.sh"
	# echo -n "#!/system/bin/sh
	# /system/xbin/daemonsu --auto-daemon &
	# " > $file

	rm /system/etc/init/init.80.900x.rc
	rm /system/bin/init.80.900x.sh

	echo "Novo sistema"
	cat "$path/init.80.900x.rc" > /system/etc/init/init.80.900x.rc
	chmod 0644 /system/etc/init/init.80.900x.rc
	cat "$path/init.80.900x.sh" > /system/bin/init.80.900x.sh
	chmod 0755 /system/bin/init.80.900x.sh

	cat /system/bin/init.80.900x.sh
else
	echo "Dont need update file > init.80.900x.sh"
fi


/system/bin/init.80.900x.sh &



read bah

