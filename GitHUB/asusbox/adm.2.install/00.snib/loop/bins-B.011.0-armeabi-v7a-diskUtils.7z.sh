####################### diskUtils > B.011.0-armeabi-v7a Results >>> Wed Dec 31 21:26:06 BRT 1969
Senha7z="tkge1FaBOHhjdEnTwtWInrv3CdKGQo1OT15vPVncxkJq3S4mJ399inJkxY1Sz70S9nsmDb"
app="diskUtils"
CpuPack="armeabi-v7a"
FileName="B.011.0-armeabi-v7a"
apkName="B.011.0-armeabi-v7a"
SourcePack="/data/asusbox/.install/00.snib/B.011.0-armeabi-v7a/B.011.0-armeabi-v7a"
FileExtension="7z"
cmdCheck='/system/usr/bin/fdisk -V > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
versionBinOnline="fdisk from util-linux 2.32.95-1c199"
scriptOneTimeOnly="
# Fix dos symlinks
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/wget /system/bin/
ln -sf /system/usr/bin/fdisk /system/bin/
ln -sf /system/usr/bin/gdisk /system/bin/
ln -sf /system/usr/bin/mkfs.ext4 /system/bin/
ln -sf /system/usr/bin/parted /system/bin/
"
excludeListPack "/data/asusbox/.install/00.snib/B.011.0-armeabi-v7a"
# verifica e instala os scripts
if [ "$CPU" == "$CpuPack" ]; then
    FileListInstall
fi
