#!/system/bin/sh

export DIR=`dirname $(dirname $0)`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
# Binário
app="screen"
apkSection="000.snib-"
FileName="B.011"
FileExtension="7z"
path="/data/asusbox/.install/00.snib"
admExport=$(dirname $0)

cmdCheck='screen -v > /data/local/tmp/swap 2>&1 && versionBinLocal=`cat /data/local/tmp/swap | sed -n 1p` && rm /data/local/tmp/swap'

eval $cmdCheck
versionBinOnline=$versionBinLocal
echo $versionBinLocal

FileList="/system/bin/screen"

scriptOneTimeOnly=""

scriptAtBoot=""

### Tasks ###############################################################################
compressTarget

rcloneUploadFileList



