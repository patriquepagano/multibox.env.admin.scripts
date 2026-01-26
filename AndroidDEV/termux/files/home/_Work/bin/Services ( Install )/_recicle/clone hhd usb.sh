#!/system/bin/sh
clear

mkdir -p "/storage/source"
mkdir -p "/storage/destiny"


/system/bin/busybox mount -t ext4 /dev/block/sda1 "/storage/source"

/system/bin/busybox mount -t ext4 /dev/block/sdb1 "/storage/destiny"


#rsync="/data/data/com.termux/files/usr/bin/rsync"
rsync --progress \
-avz \
--delete \
--recursive \
--exclude 'lost+found' \
"/storage/source/" \
"/storage/destiny/"










exit







