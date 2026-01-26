#!/system/bin/sh

export DIR=`dirname $(dirname $0)`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="XdNUxOQMAdGHetQMeynMNbT81WCnoVjvxj67EcUA6kmAkjhTjSgAe2fwVhOMF2RRe0ovlV"

app="www fontawesome"
apkSection="004.0-#######-www-fontawesome-"
FileName="004.0"
FileExtension="WebPack"
path="/data/asusbox/.install/02.files"
pathToInstall="/storage/emulated/0/Android/data/asusbox/.www/.fontawesome"
DevFolder="/storage/DevMount/GitHUB/asusbox/adm.build/www/.fontawesome"
admExport=$(dirname $0)
ExcludeItens="LICENSE.txt"

cmdCheck='versionBinLocal=`/system/bin/busybox head -1 /storage/emulated/0/Android/data/asusbox/.www/.fontawesome/version`'
# eval $cmdCheck
versionBinOnline="function exportWwwAssets preenche"

FileList="$GenPackF"
SCRIPT=`realpath $0`
### Tasks ###############################################################################
RsyncGenPackF

compressTargetDir

exportWwwAssets
