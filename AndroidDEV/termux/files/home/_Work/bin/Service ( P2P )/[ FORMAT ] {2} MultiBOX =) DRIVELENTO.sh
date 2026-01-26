#!/system/bin/sh
path=$( cd "${0%/*}" && pwd -P )
clear
Log="/data/trueDT/peer/TMP/init.p2p.LOG"
toolx="/system/bin/busybox"

export FolderPath="/storage/MultiBOX"


Partition=`$toolx blkid | $toolx grep 'LABEL="MultiBOX"' | $toolx grep -v vold | $toolx head -n 1 | $toolx cut -d ":" -f 1`
echo $Partition
MBR=`echo $Partition | $toolx sed 's/.\{1\}$//'`
echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### Particionando USB Drive FAT32"
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
) | /system/usr/bin/fdisk -w always -W always $MBR > /dev/null 2>&1
echo "ADM DEBUG ### Listando particionamento FAT32"
/system/usr/bin/fdisk -l $MBR

echo "ADM DEBUG ########################################################"
echo "ADM DEBUG ### Formatando Drive Lento"
/system/bin/newfs_msdos -A -F 32 -L DriveLento $Partition > /dev/null 2>&1

echo "ADM DEBUG ### Formatado com sucesso DriveLento!"
$toolx blkid | $tools grep "DriveLento"


