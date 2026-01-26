#!/system/bin/sh
clear
fdisk=/storage/DevMount/GitHUB/asusbox/adm.debugs/_install_base_system/3_bin_Disk.Utils/armeabi-v7a/fdisk
gdisk=/storage/DevMount/GitHUB/asusbox/adm.debugs/_install_base_system/3_bin_Disk.Utils/armeabi-v7a/gdisk
mkfs_ext4=/storage/DevMount/GitHUB/asusbox/adm.debugs/_install_base_system/3_bin_Disk.Utils/armeabi-v7a/mkfs.ext4
parted=/storage/DevMount/GitHUB/asusbox/adm.debugs/_install_base_system/3_bin_Disk.Utils/armeabi-v7a/parted

# sm unmount public:8,17
# sm unmount public:8,1


# blkid
# df -h
# sm list-volumes
# /system/bin/busybox fdisk -l /dev/block/sda
# /system/bin/busybox fdisk -l /dev/block/sdb

cat /proc/partitions

part="sdb"


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
) | $fdisk -w always -W always /dev/block/$part


/system/bin/busybox fdisk -l /dev/block/$part

# Formata Fatezao
/system/bin/newfs_msdos -F 32 -L Fatezao /dev/block/"$part"1

cat /proc/partitions
blkid
