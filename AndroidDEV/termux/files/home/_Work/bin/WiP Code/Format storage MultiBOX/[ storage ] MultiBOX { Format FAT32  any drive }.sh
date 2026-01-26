#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear


# desmontar apenas o usb MEFORMATE
busybox blkid
echo "ADM DEBUG digite o path? ex: /dev/block/sdb"
read MBR
echo "ADM DEBUG digite o path /dev/block/vold/public: ? ex: 8,17"
read publicM

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### MBR = $MBR"
echo "ADM DEBUG ### Public mount point = public:$publicM"

if [ ! "$MBR" == "" ]; then

# verificar se esta montado public mount point
check=`busybox mount | busybox grep "public:$publicM"`
if [ ! "$check" == "" ]; then
	echo "ADM DEBUG ### precisa desmontar unidade > public:$publicM"
	sm unmount public:$publicM
fi

/system/bin/busybox umount -f $MBR'1' > /dev/null 2>&1

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### Particionando USB Drive"
(
echo o # Create a new empty DOS partition table
echo n # Add a new partition
echo p # Primary partition
echo 1 # Partition number
echo   # First sector (Accept default: 1)
echo   # Last sector (Accept default: varies)
echo t # escolher o type da partiçao
echo c # ID c W95 FAT32 (LBA) default do formatado geniusDesk
echo a # make a partition bootable
echo p # print the in-memory partition table
echo w # write the partition table
echo q # and we're done
) | /system/usr/bin/fdisk -w always -W always $MBR
/system/usr/bin/fdisk -l $MBR

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### Formata MEFORMATE"
/system/bin/newfs_msdos -A -F 32 -L MEFORMATE $MBR'1'

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




# no geniusDesk o ID é 0C ou OC
# /system/usr/bin/fdisk -l /dev/block/sdb
# geniusDesk format >  /dev/block/sdb1 *     2048 30529535 30527488 14.6G  c W95 FAT32 (LBA)

# usage: newfs_msdos [ -options ] special [disktype]
# where the options are:
#         -@ create file system at specified offset
#         -A Attempt to cluster align root directory
#         -B get bootstrap from file
#         -C create image file with specified size
#         -F FAT type (12, 16, or 32)
#         -I volume ID
#         -L volume label
#         -N don't create file system: just print out parameters
#         -O OEM string
#         -S bytes/sector
#         -a sectors/FAT
#         -b block size
#         -c sectors/cluster
#         -e root directory entries
#         -f standard format
#         -h drive heads
#         -i file system info sector
#         -k backup boot sector
#         -m media descriptor
#         -n number of FATs
#         -o hidden sectors
#         -r reserved sectors
#         -s file system size (sectors)
#         -u sectors/track

exit
