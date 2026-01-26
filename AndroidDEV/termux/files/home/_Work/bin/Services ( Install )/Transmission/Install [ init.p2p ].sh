#!/system/bin/sh

path=$( cd "${0%/*}" && pwd -P )

OldFile=`cat /system/bin/init.p2p.sh`
NewFile=`cat "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.install/.termuxOpensshGit/init.p2p.sh"`


if [ ! "$OldFile" == "$NewFile" ]; then
	/system/bin/busybox mount -o remount,rw /system
	# echo "limpando sistema antigo"

	# file="/system/bin/rootsudaemon.sh"
	# echo -n "#!/system/bin/sh
	# /system/xbin/daemonsu --auto-daemon &
	# " > $file

	rm /system/etc/init/init.p2p.rc
	rm /system/bin/init.p2p.sh

	echo "Novo sistema"
	cat "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.install/.termuxOpensshGit/init.p2p.rc" > /system/etc/init/init.p2p.rc
	chmod 0644 /system/etc/init/init.p2p.rc
	cat "/storage/DevMount/AndroidDEV/termux/files/home/_Work/bin/.install/.termuxOpensshGit/init.p2p.sh" > /system/bin/init.p2p.sh
	chmod 0755 /system/bin/init.p2p.sh

	cat /system/bin/init.p2p.sh
else
	echo "Dont need update file > init.p2p.sh"
fi

