#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear



# # usando sdcard não deu muito certo, ate conseguiu particionar mas não refletiu as mudanças na hora. 
# MBR=/dev/block/mmcblk0
# part1=/dev/block/mmcblk0p1
# publicM=/dev/block/mmcblk0p1

MBR=/dev/block/sdb
part1=/dev/block/sdb1



UUID=`busybox blkid | busybox grep "$part1" | busybox grep "UUID" | busybox cut -d '"' -f 2`
publicM=`busybox blkid | busybox grep "$UUID" | busybox grep "public" | busybox cut -d ":" -f 2`
echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### MBR = $MBR"
echo "ADM DEBUG ### Public mount point = public:$publicM"


# read BAH
# exit



if [ ! "$MBR" == "" ]; then

# verificar se esta montado public mount point
check=`busybox mount | busybox grep "public:$publicM"`
if [ ! "$check" == "" ]; then
	echo "ADM DEBUG ### precisa desmontar unidade > public:$publicM"
	sm unmount public:$publicM
fi

# verificar se esta montado usando /dev/block/sd*

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### Particionando USB Drive"
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
) | /system/usr/bin/fdisk -w always -W always $MBR
/system/usr/bin/fdisk -l $MBR

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### Formata MultiBOX"
/system/usr/bin/mkfs.ext4 -t ext4 -L "MultiBOX" $part1 <<BAH
y
BAH










fi

echo "
### blkid"
busybox blkid
echo "
### mounted public"
busybox mount | grep public
echo "
### mounted manual"
busybox mount | grep "/storage/DevMount"
busybox mount | grep "/storage/MultiBOX"

