#!/system/bin/sh

/system/bin/busybox blkid | grep "/dev/block/sdb1"
/system/bin/busybox tune2fs -L ThumbDriveDEV /dev/block/sdb1
#/system/bin/busybox tune2fs -O^metadata_csum /dev/block/sdb1
/system/bin/busybox blkid | grep "/dev/block/sdb1"

exit



tune2fs –L ROOT_PART /dev/sda1