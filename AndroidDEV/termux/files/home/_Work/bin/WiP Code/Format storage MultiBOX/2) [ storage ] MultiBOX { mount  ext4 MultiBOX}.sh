#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear





FolderPath="/storage/MultiBOX"
if [ ! -d $FolderPath ]; then
	mkdir $FolderPath
	chmod 700 $FolderPath
fi
/system/bin/busybox mount -t ext4 /dev/block/sdb1 "$FolderPath"



busybox mount | grep "/storage/DevMount"
busybox mount | grep "/storage/MultiBOX"


exit

/system/bin/busybox blkid | /system/bin/busybox grep "MultiBOX" | /system/bin/busybox head -n 1 | /system/bin/busybox cut -d "=" -f 3 | /system/bin/busybox cut -d '"' -f 2

FolderPath="/storage/MultiBOX"
UUID=`/system/bin/busybox blkid | /system/bin/busybox grep "MultiBOX" | /system/bin/busybox head -n 1 | /system/bin/busybox cut -d "=" -f 3 | /system/bin/busybox cut -d '"' -f 2`
if [ ! $UUID == "" ]; then    
	if [ ! -d $FolderPath ]; then
		mkdir $FolderPath
		chmod 700 $FolderPath
	fi
	# montando o device
	/system/bin/busybox umount -f $FolderPath > /dev/null 2>&1
	check=`/system/bin/busybox mount | /system/bin/busybox grep "$FolderPath"`
	if [ "$check" == "" ]; then
		echo "ADM DEBUG ########################################################"
		echo "ADM DEBUG ### $FolderPath MONTANDO como pasta MultiBOX for users"
		/system/bin/busybox mount -t ext4 LABEL="MultiBOX" "$FolderPath"
	fi
	# # Symlink
	# rm /data/asusbox/.install > /dev/null 2>&1    
	# /system/bin/busybox ln -sf $FolderPath/asusbox/.install /data/asusbox/
	# InstallFolder="ENABLED"
	# echo "ADM DEBUG ########################################################"
	# echo "ADM DEBUG ### $FolderPath ativado como pasta .install"
fi


echo "
### blkid"
busybox blkid
echo "
### mounted public"
busybox mount | grep public
echo "
### mount"
busybox mount | grep "/storage/DevMount"
busybox mount | grep "/storage/MultiBOX"
