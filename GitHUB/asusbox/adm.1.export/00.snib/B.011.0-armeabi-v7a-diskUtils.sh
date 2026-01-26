#!/system/bin/sh

export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="tkge1FaBOHhjdEnTwtWInrv3CdKGQo1OT15vPVncxkJq3S4mJ399inJkxY1Sz70S9nsmDb"
# Binário
app="diskUtils"
apkSection="bins"
CpuPack="armeabi-v7a"
FileName="B.011.0-$CpuPack"
apkName="$FileName"
FileExtension="7z"
path="/data/asusbox/.install/00.snib"
admExport=$(dirname "$0")

cmdCheck='/system/usr/bin/fdisk -V > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'

eval $cmdCheck
versionBinOnline=$versionBinLocal
echo $versionBinLocal

FileList="/system/usr/bin/fdisk
/system/usr/bin/gdisk
/system/usr/bin/mkfs.ext4
/system/usr/bin/parted"

scriptOneTimeOnly="
# Fix dos symlinks
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/wget /system/bin/
ln -sf /system/usr/bin/fdisk /system/bin/
ln -sf /system/usr/bin/gdisk /system/bin/
ln -sf /system/usr/bin/mkfs.ext4 /system/bin/
ln -sf /system/usr/bin/parted /system/bin/
"

scriptAtBoot=''
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
compressTarget

exportVarsBINs









