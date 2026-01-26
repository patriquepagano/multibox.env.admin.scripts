#!/system/bin/sh

export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="D2XL1wPhGR1Sb0dtJDkdGo18wHGQcbiIOGLo5SbL9Gjaar2HqQC0coypPRRdiyrtg131vS"
# Binário
app="busybox"
apkSection="bins"
CpuPack="armeabi-v7a"
FileName="B.001.0-$CpuPack"
apkName="$FileName"
FileExtension="7z"
path="/data/asusbox/.install/00.snib"
admExport=$(dirname "$0")

cmdCheck='/system/bin/busybox > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'
#cmdCheck='versionBinLocal=`/system/bin/busybox md5sum "/system/bin/busybox"`'
eval $cmdCheck
versionBinOnline=$versionBinLocal
echo $versionBinLocal

FileList="/system/bin/busybox
/system/bin/ssl_helper"
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
compressTarget

exportVarsBINs

