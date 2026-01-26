
tudo abaixo foi testado e não funcionoou


busybox umount /sdcard/Download
busybox umount /storage/emulated

bindfs="/storage/DevMount/4Android/bindfs-armeabi-v7a"

$bindfs -h

fbind -b /storage/DevMount/4Android /sdcard/Download

# $DIR/WhatsApp /mnt/runtime/write/emulated/0/WhatsApp


echo "---"
echo "block info"
echo "$(busybox blkid | busybox grep "sd")"
echo "---"
echo "mounted"
echo "$(busybox mount | busybox grep 'sd')"
echo "$(busybox mount | busybox grep 'vold')"
echo "---"
echo "space"
# echo "$(busybox df -P -h | busybox grep 'vold')"
# echo "$(busybox df -P -h | busybox grep 'sd')"

busybox df -P -h


exit

$bindfs -o \
--force-user=0 \
--force-group=1015 \
--xattr-none \
--chown-ignore \
--chgrp-ignore \
--chmod-ignore \
--create-for-user=0 \
--create-for-group=1015 \
/storage/DevMount/4Android /sdcard/Download


busybox chmod 777 -R /sdcard/Download
busybox chown root:sdcard_r -R /sdcard/Download





$bindfs -o nosuid,nodev,noexec,noatime,context=u:object_r:sdcardfs:s0 -u 0 -g 9997 -p a-rwx,ug+rw,ugo+X \
--create-with-perms=a-rwx,ug+rw,ugo+X \
--xattr-none \
--chown-ignore \
--chgrp-ignore \
--chmod-ignore \
/storage/DevMount/4Android /mnt/runtime/write/emulated/0/Download





su - sdcard_r -c busybox mount -o bind /storage/DevMount/4Android /sdcard/Download

echo "Now attempting to remount root filesystem RW"
/system/bin/busybox mount -o remount,rw /
echo "Make the internal_sd directory"
mkdir -p /storage/DevMount/4Android
echo "Bind the internal sdcard to the new folder"
mount -o bind /mnt/sdcard /storage/DevMount/4Android
echo "Mount the real sdcard"
#mount -t vfat -o umask=0000 /dev/block/vold/179:25 /mnt/sdcard
echo "Bind the internal_sd directory to the extSdCard mountpoint"
mount -o bind /storage/DevMount/4Android /mnt/extSdCard
echo "Script done"


busybox mount -o bind,dmask=0000,fmask=0000 /storage/DevMount/4Android /sdcard/Download

busybox mount -o bind /mnt/media_rw/12025088-f712-a441-9478-83ffd2c1fe11/4Android /sdcard/Download
busybox mount -t sdcardfs -o nosuid,nodev,noexec,noatime,mask=7,gid=9997 /mnt/media_rw/12025088-f712-a441-9478-83ffd2c1fe11/4Android /sdcard/Download

# tb num deu!
# /dev/fuse on /storage/emulated type fuse (rw,nosuid,nodev,noexec,noatime,user_id=1023,group_id=1023,default_permissions,allow_other)
busybox mount -o bind /storage/DevMount/4Android /sdcard/Download
busybox chmod 777 -R /sdcard/Download
busybox chown 1023:1023 -R /sdcard/Download

# lista os arquivos mas não instala
#mount -o bind /storage/DevMount/4Android /mnt/runtime/write/emulated/0/Download
busybox mount -o bind /storage/DevMount/4Android /sdcard/Download
busybox chmod 777 -R /sdcard/Download
busybox chown root:sdcard_r -R /sdcard/Download



# nem sequer lista os arquivos em /sdcard/Download
# sm unmount public:8,17
#mount -o bind /storage/DevMount/4Android /mnt/runtime/write/emulated/0/Download
busybox mount -o bind /storage/DevMount/4Android /sdcard/Download
# default permission
# 771 drwxrwx--x    2 root     sdcard_r      4096 Dec 20 00:19 Download
busybox chmod 771 /sdcard/Download
busybox chown root:sdcard_r -R /sdcard/Download








mount -o bind /mnt/my_sdcard/WhatsApp /mnt/runtime/write/emulated/0/WhatsApp

busybox mount -t exfat -o nosuid,nodev,noexec,noatime,context=u:object_r:sdcardfs:s0,uid=0,gid=9997,fmask=0117,dmask=0006 /dev/block/sdb1 /mnt/runtime/write/emulated/0/Download







[ $(readlink /proc/1/ns/mnt) = $(readlink /proc/self/ns/mnt) ] || busybox nsenter -t 1 -m /system/bin/sh


mount -t exfat -o nosuid,nodev,noexec,noatime,context=u:object_r:sdcardfs:s0,uid=0,gid=9997,fmask=0117,dmask=0006 /dev/block/sda1 /mnt/runtime/write/emulated/0/WhatsApp



mv /data/media/0/WhatsApp/* /sdcard/WhatsApp/

