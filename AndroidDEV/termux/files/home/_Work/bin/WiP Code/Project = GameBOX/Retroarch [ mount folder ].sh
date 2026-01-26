#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear

# estudo para montar pasta de roms no sdcard no futuro


exit


echo "Montando a pasta dos apks"

busybox umount /mnt/runtime/write/emulated/0/Download
busybox umount /mnt/runtime/read/emulated/0/Download
busybox umount /sdcard/Download
busybox umount /storage/emulated/0/Download

# funciona e monta para todos os apps! mas um arquivo criado pelo MixPlorer levou permissao do mixplorer
busybox chmod 777 -R /storage/DevMount/4Android
# criar uma pasta no sdcard para a montagem no futuro fazer o mesmo para o retroarch
mkdir -p /sdcard/4Android
busybox chmod 777 /sdcard/4Android
# montagem temporaria das pastas
busybox mount -o bind /storage/DevMount/4Android /mnt/runtime/read/emulated/0/4Android
busybox mount -o bind /storage/DevMount/4Android /mnt/runtime/write/emulated/0/4Android
busybox mount -o bind /storage/DevMount/4Android /sdcard/4Android
busybox mount -o bind /storage/DevMount/4Android /storage/emulated/0/4Android


/system/bin/busybox blkid | /system/bin/busybox grep "MultiBOX" | /system/bin/busybox head -n 1 | /system/bin/busybox cut -d "=" -f 3 | /system/bin/busybox cut -d '"' -f 2

FolderPath="/storage/MultiBOX"
UUID=`/system/bin/busybox blkid | /system/bin/busybox grep "MultiBOX" | /system/bin/busybox head -n 1 | /system/bin/busybox cut -d "=" -f 3 | /system/bin/busybox cut -d '"' -f 2`
if [ ! $UUID == "" ]; then    
	if [ ! -d $FolderPath ] ; then
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
