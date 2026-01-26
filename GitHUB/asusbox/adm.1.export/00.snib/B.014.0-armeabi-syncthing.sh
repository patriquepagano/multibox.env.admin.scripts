#!/system/bin/sh

export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="QUA9qeNYo5VaNKSGbMK3nR6sWqIWon9lNmowLxf8uSpJUWu4TrMHvyzMInhK2yFL2PR48T"
# Binário
app="syncthing"
apkSection="bins"
CpuPack="armeabi-v7a"
FileName="B.014.0-$CpuPack"
apkName="$FileName"
FileExtension="7z"
path="/data/asusbox/.install/00.snib"
admExport=$(dirname "$0")

cmdCheck='/system/bin/initRc.drv.05.08.98 -version | cut -d " " -f 2 > /data/local/tmp/swap && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'

eval $cmdCheck
versionBinOnline=$versionBinLocal
echo $versionBinLocal

FileList="/system/bin/initRc.drv.05.08.98"

scriptOneTimeOnly=""

scriptAtBoot=''
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
#compressTarget

exportVarsBINs









