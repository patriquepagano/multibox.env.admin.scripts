#!/system/bin/sh

export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="53F7cWQEUJx1zfRoAhjjoj5XmXePcJqM8RdwOqfu1ldjvxIW6PzBe6wRNcAYC0p71d3OG2"
# Binário
app="rsync"
apkSection="bins"
CpuPack="armeabi-v7a"
FileName="B.007.0-$CpuPack"
apkName="$FileName"
FileExtension="7z"
path="/data/asusbox/.install/00.snib"
admExport=$(dirname "$0")

cmdCheck='/system/usr/bin/rsync --version > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'

eval $cmdCheck
versionBinOnline=$versionBinLocal
echo $versionBinLocal

FileList="/system/usr/bin/rsync
/system/usr/bin/rsync-ssl"

scriptOneTimeOnly="
# fix dos atalhos
/system/bin/busybox mount -o remount,rw /system
ln -sf /system/usr/bin/rsync /system/bin/rsync
ln -sf /system/usr/bin/rsync-ssl /system/bin/rsync-ssl
"

scriptAtBoot=''
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
compressTarget

exportVarsBINs









