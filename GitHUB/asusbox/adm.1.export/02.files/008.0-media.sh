#!/system/bin/sh

export DIR=`dirname $(dirname $0)`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="yZE4TIqkvLNboXONJe56ULwNqbJlpB5Kj2vJSvTiOtNZxZIUukPRxUeIcAYT2kSzUoOFc8"
# Binário
app="mediaintro"
apkSection="008.0-#######-media-intro-"
FileName="008.0"
FileExtension="7z"
path="/data/asusbox/.install/02.files"
admExport=$(dirname $0)

cmdCheck='versionBinLocal=`du -sh /system/media/bootanimation.zip`'

eval $cmdCheck
versionBinOnline=$versionBinLocal
echo $versionBinLocal

FileList="/system/media/audio/ui/WirelessChargingStarted.ogg
/system/media/bootanimation.zip"

scriptOneTimeOnly=""

scriptAtBoot=""
SCRIPT=`realpath $0`
### Tasks ###############################################################################
compressTarget

exportVarsFiles

