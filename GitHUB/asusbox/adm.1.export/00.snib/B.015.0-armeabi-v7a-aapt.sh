#!/system/bin/sh

export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="Bm4jxlld4c1zWPfoxKc3cgQex5edz1JgYoumdpcoEwTFwYIKZoI6pK0WHjPTntiThHYADW"
# Binário
app="aapt"
apkSection="bins"
CpuPack="armeabi-v7a"
FileName="B.015.0-$CpuPack"
apkName="$FileName"
FileExtension="7z"
path="/data/asusbox/.install/00.snib"
admExport=$(dirname "$0")

cmdCheck='/system/usr/bin/aapt version | cut -d " " -f 5 > /data/local/tmp/swap && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'

eval $cmdCheck
versionBinOnline=$versionBinLocal
echo $versionBinLocal

FileList="/system/usr/bin/aapt
/system/usr/bin/libaapt.so"

scriptOneTimeOnly=""

scriptAtBoot=''
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
#compressTarget

exportVarsBINs




