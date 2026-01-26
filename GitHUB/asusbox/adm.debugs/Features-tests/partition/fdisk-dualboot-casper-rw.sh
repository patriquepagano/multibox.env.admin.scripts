#!/system/bin/sh

# sm unmount public:8,17
# sm unmount public:8,1


clear

# blkid
# df -h
# sm list-volumes
# /system/bin/busybox fdisk -l /dev/block/sda
# /system/bin/busybox fdisk -l /dev/block/sdb

dd if=/dev/zero of=/dev/block/sdc bs=512 count=1
cat /proc/partitions


# Partition #1 contains a ext4 signature.
# Do you want to remove the signature? [Y]es/[N]o: Y


(
echo o # Create a new empty DOS partition table
echo n # Add a new partition
echo p # Primary partition
echo 1 # Partition number
echo   # First sector (Accept default: 1)
echo +2500MB #  bota o tamanho para abrigar as isos
echo  n # new partition
echo  p # primary partition
echo  2 # partion number 2
echo    # default - start at beginning of disk 
echo   # casper
echo  a # make a partition bootable
echo  1 # bootable partition is partition 1 -- /dev/sda1
echo  p # print the in-memory partition table
echo  w # write the partition table
echo  q # and we're done
) | /data/local/tmp/fdisk -w always -W always /dev/block/sda



/system/bin/busybox fdisk -l /dev/block/sda



# Formata EFI
/system/bin/newfs_msdos -F 32 -L EFI /dev/block/sda1

# # verifica se o fat esta corrompido
# sudo dosfsck -w -r -l -a -v -t /dev/"$MBR"1

# Formata casper-rw
toybox yes | formatar -t ext4 -L "casper-rw" /dev/block/sda2


# /system/bin/busybox tune2fs -L "AsusBOX-PC" /dev/block/sda1


### pendrive LABEL="Android-x86"
# Disk /dev/block/sda: 29 GB, 31104958464 bytes, 60751872 sectors
# 3781 cylinders, 255 heads, 63 sectors/track
# Units: sectors of 1 * 512 = 512 bytes

# Device        Boot StartCHS    EndCHS        StartLBA     EndLBA    Sectors  Size Id Type
# /dev/block/sda1 *  0,32,33     1023,254,63       2048   60751871   60749824 28.9G  c Win95 FAT32 (LBA)


