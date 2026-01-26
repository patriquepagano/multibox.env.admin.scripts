#!/system/bin/sh

export DIR=`dirname $(dirname $0)`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="IWDloBJ4vWAyqeREICGFXgxvrtwgJfdgytSd9cQaD6kLszQWfVuMJseh1tQ7GYzVdgJ2XQ"

app="www asusbox OnLine"
apkSection="006.0-#######-www-asusbox-OnLine-"
FileName="006.0"
FileExtension="WebPack"
path="/data/asusbox/.install/02.files"
pathToInstall="/storage/emulated/0/Android/data/asusbox/.www"
DevFolder="/storage/DevMount/GitHUB/asusbox/adm.build/www"
admExport=$(dirname $0)
ExcludeItens=".code
.fontawesome
.img.launcher
boot-files
boot.log
qrIP.png"

cmdCheck='versionBinLocal=`/system/bin/busybox head -1 /storage/emulated/0/Android/data/asusbox/.www/version`'
# eval $cmdCheck
versionBinOnline="function exportWwwAssets preenche"

FileList="$GenPackF"
SCRIPT=`realpath $0`
### Tasks ###############################################################################
RsyncGenPackF
obfuscatePHP
compressTargetDir

exportWwwAssets


