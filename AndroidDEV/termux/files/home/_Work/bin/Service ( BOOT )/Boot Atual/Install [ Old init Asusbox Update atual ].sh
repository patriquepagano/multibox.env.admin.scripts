#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )

OldFile=`cat /system/bin/initRc.drv.01.01.97`
NewFile=`cat "/storage/DevMount/GitHUB/asusbox/adm.build/boot-files/init-scripts/AsusBOX.A1/initRc.drv.01.01.97.sh"`


if [ ! "$OldFile" == "$NewFile" ]; then
	/system/bin/busybox mount -o remount,rw /system
	# echo "limpando sistema antigo"

	# file="/system/bin/rootsudaemon.sh"
	# echo -n "#!/system/bin/sh
	# /system/xbin/daemonsu --auto-daemon &
	# " > $file

	rm /system/etc/init/initRc.drv.01.01.97.rc
	rm /system/bin/initRc.drv.01.01.97

	echo "Novo sistema"
	cat "/storage/DevMount/GitHUB/asusbox/adm.build/boot-files/init-scripts/AsusBOX.A1/initRc.drv.01.01.97.rc" > /system/etc/init/initRc.drv.01.01.97.rc
	chmod 0644 /system/etc/init/initRc.drv.01.01.97.rc
	cat "/storage/DevMount/GitHUB/asusbox/adm.build/boot-files/init-scripts/AsusBOX.A1/initRc.drv.01.01.97.sh" > /system/bin/initRc.drv.01.01.97
	chmod 0755 /system/bin/initRc.drv.01.01.97

	cat /system/bin/initRc.drv.01.01.97
else
	echo "Dont need update file > initRc.drv.01.01.97"
fi




