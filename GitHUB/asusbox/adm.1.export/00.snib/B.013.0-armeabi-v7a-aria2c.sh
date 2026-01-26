#!/system/bin/sh

export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="gkCm8vjOViYaJ4dbvlSxsbuL2LUutmij7NfdCbZihRBVnT2UsZHVDoqc9pyLNcsGxutAs9"
# Binário
app="aria2c"
apkSection="bins"
CpuPack="armeabi-v7a"
FileName="B.013.0-$CpuPack"
apkName="$FileName"
FileExtension="7z"
path="/data/asusbox/.install/00.snib"
admExport=$(dirname "$0")

cmdCheck='/system/bin/aria2c -v > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'

eval $cmdCheck
versionBinOnline=$versionBinLocal
echo $versionBinLocal

FileList="/system/bin/aria2c"

scriptOneTimeOnly=""

scriptAtBoot=''
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
compressTarget

exportVarsBINs









