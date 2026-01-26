#!/system/bin/sh
clear
# sm unmount public:8,17
# sm unmount public:8,1

blkid
df -h
sm list-volumes
# /system/bin/busybox fdisk -l /dev/block/sda
# /system/bin/busybox fdisk -l /dev/block/sdb

cat /proc/partitions



part="sdc"

(
echo o # Create a new empty DOS partition table
echo n # Add a new partition
echo p # Primary partition
echo 1 # Partition number
echo   # First sector (Accept default: 1)
echo   # Last sector (Accept default: varies)
echo a # make a partition bootable
echo p # print the in-memory partition table
echo w # write the partition table
echo q # and we're done
) | fdisk -w always -W always /dev/block/$part


fdisk -l /dev/block/$part

#mkfs.ext4 -t ext4 -L "asusboxUpdate" -U "cf3f1700-7709-43f9-a6f3-7b8b18c5e224" /dev/block/"$part"1





cat /proc/partitions
blkid


exit


mkdir /storage/asusboxUpdate
chmod 777 /storage/asusboxUpdate
/system/bin/busybox mount -t ext4 LABEL="asusboxUpdate" /storage/asusboxUpdate



# /system/bin/busybox tune2fs -L "AsusBOX-PC" /dev/block/sda1


### pendrive LABEL="Android-x86"
# Disk /dev/block/sda: 29 GB, 31104958464 bytes, 60751872 sectors
# 3781 cylinders, 255 heads, 63 sectors/track
# Units: sectors of 1 * 512 = 512 bytes

# Device        Boot StartCHS    EndCHS        StartLBA     EndLBA    Sectors  Size Id Type
# /dev/block/sda1 *  0,32,33     1023,254,63       2048   60751871   60749824 28.9G  c Win95 FAT32 (LBA)





