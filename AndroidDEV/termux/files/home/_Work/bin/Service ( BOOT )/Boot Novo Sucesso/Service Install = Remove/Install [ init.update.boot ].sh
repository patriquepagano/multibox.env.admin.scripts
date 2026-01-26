#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear

OldFile=`cat /system/bin/init.update.boot.sh`
NewFile=`cat "$path/init.update.boot.SH"`


if [ ! "$OldFile" == "$NewFile" ]; then
	/system/bin/busybox mount -o remount,rw /system
	rm /system/etc/init/init.update.boot.rc > /dev/null 2>&1
	rm /system/bin/init.update.boot.sh > /dev/null 2>&1
	echo "Novo sistema"
	cat "$path/init.update.boot.rc" > /system/etc/init/init.update.boot.rc
	chmod 0644 /system/etc/init/init.update.boot.rc
	cat "$path/init.update.boot.SH" > /system/bin/init.update.boot.sh
	chmod 0755 /system/bin/init.update.boot.sh

	cat /system/bin/init.update.boot.sh
else
	echo "Dont need update file > init.update.boot.sh"
fi

echo "Precisa reiniciar para o serviço funcionar em automatico"

#/system/bin/init.update.boot.sh

	# echo "limpando sistema antigo"

	# file="/system/bin/rootsudaemon.sh"
	# echo -n "#!/system/bin/sh
	# /system/xbin/daemonsu --auto-daemon &
	# " > $file


read bah