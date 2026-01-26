#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear

OldFile=`cat /system/bin/init.21027.sh`
NewFile=`cat "$path/init.21027.SH"`


if [ ! "$OldFile" == "$NewFile" ]; then
	/system/bin/busybox mount -o remount,rw /system

	rm /system/etc/init/init.21027.rc
	rm /system/bin/init.21027.sh

	echo "Novo sistema"
	cat "$path/init.21027.rc" > /system/etc/init/init.21027.rc
	chmod 0644 /system/etc/init/init.21027.rc
	cat "$path/init.21027.SH" > /system/bin/init.21027.sh
	chmod 0755 /system/bin/init.21027.sh

	cat /system/bin/init.21027.sh
else
	echo "Dont need update file > init.21027.sh"
fi

du -hs /system/bin/init.21027.sh




echo "Precisa reiniciar para o serviço funcionar em automatico"
#/system/bin/init.21027.sh #& > /dev/null 2>&1





# não funciona utilizar como user sdcard
# busybox mount | busybox grep '/storage/emulated' \
#   | busybox awk -F',' '{ for(i=1;i<=NF;i++){
#        if($i ~ /user_id=/)  u=substr($i,9)
#        if($i ~ /group_id=/) g=substr($i,10)
#      }} END{ print "UID="u, "GID="g }'


# não funciona este start
# # em root shell (ou com “su -c”):
# setprop ctl.start init21027

# sleep 3

# info


read bah





	# echo "limpando sistema antigo"

	# file="/system/bin/rootsudaemon.sh"
	# echo -n "#!/system/bin/sh
	# /system/xbin/daemonsu --auto-daemon &
	# " > $file