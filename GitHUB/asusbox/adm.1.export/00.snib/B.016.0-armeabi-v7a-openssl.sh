#!/system/bin/sh

export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="tQaiSAQPhgAkQ7wB20ulZpHnC1EZZvb4aOGsG7m13JnhLc2ikEejmlWADKNp4fUrIBZpzk"
# Binário
app="openssl"
apkSection="bins"
CpuPack="armeabi-v7a"
FileName="B.016.0-$CpuPack"
apkName="$FileName"
FileExtension="7z"
path="/data/asusbox/.install/00.snib"
admExport=$(dirname "$0")

cmdCheck='/system/usr/bin/openssl version | cut -d " " -f 2 > /data/local/tmp/swap && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'

eval $cmdCheck
versionBinOnline=$versionBinLocal
echo $versionBinLocal

FileList="/system/usr/bin/openssl"

scriptOneTimeOnly=""

scriptAtBoot=''
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
compressTarget

exportVarsBINs




