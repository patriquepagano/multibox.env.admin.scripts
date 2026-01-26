#!/system/bin/sh

export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="S1IiSP6YHAcIYPgXz8urgne2xvKpcGFkVqYQdw3RO6nWa0JKMxTBAm158h2lxv2RXcO9cb"
# Binário
app="transmission"
apkSection="005.0-#######-P2P-bin-"
CpuPack="armeabi-v7a"
FileName="B.009.0-$CpuPack"
FileExtension="7z"
path="/data/local/tmp"
admExport=$(dirname "$0")

cmdCheck='/system/bin/transmission-remote -V > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'

eval $cmdCheck
versionBinOnline=$versionBinLocal
echo $versionBinLocal

FileList="/system/usr/bin/transmission-create
/system/usr/bin/transmission-remote
/system/usr/bin/transmission-edit
/system/usr/bin/transmission-show
/system/usr/bin/transmission-daemon
/system/usr/share/transmission
/system/usr/lib/libminiupnpc.so
/system/usr/lib/libevent-2.1.so
/system/usr/lib/libcurl.so
/system/usr/lib/libssl.so.1.1
/system/usr/lib/libcrypto.so.1.1
/system/usr/lib/libz.so.1
/system/usr/lib/libz.so.1.2.11
/system/usr/lib/libnghttp2.so
/system/usr/lib/libssh2.so"

scriptOneTimeOnly="
# Fix dos symlinks
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/transmission-create /system/bin/
ln -sf /system/usr/bin/transmission-remote /system/bin/
ln -sf /system/usr/bin/transmission-edit /system/bin/
ln -sf /system/usr/bin/transmission-show /system/bin/
ln -sf /system/usr/bin/transmission-daemon /system/bin/
"


scriptAtBoot=''
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
# compressTarget

rcloneUploadFileList









