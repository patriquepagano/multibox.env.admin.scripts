#!/system/bin/sh

export DIR=`dirname $(dirname $0)`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="jJocyF4Ydw2wxdQB84u2Kou0i4DfJ6kSzBGQo98WsZ6xJ4ce9AgX388JRQpDnCpgb6szWw"

app="boot img"
apkSection="001.0-#######-boot-img-"
FileName="001.0"
FileExtension="WebPack"
path="/data/asusbox/.install/02.files"
pathToInstall="/storage/emulated/0/Android/data/asusbox/.www/boot-files"
DevFolder="/storage/DevMount/GitHUB/asusbox/adm.build/boot-img"
admExport=$(dirname $0)
ExcludeItens="LICENSE.txt"

cmdCheck='versionBinLocal=`/system/bin/busybox head -1 /storage/emulated/0/Android/data/asusbox/.www/boot-files/version`'
# eval $cmdCheck
versionBinOnline="function exportWwwAssets preenche"

FileList="$GenPackF"
SCRIPT=`realpath $0`
### Tasks ###############################################################################
RsyncGenPackF

compressTargetDir

exportWwwAssets
