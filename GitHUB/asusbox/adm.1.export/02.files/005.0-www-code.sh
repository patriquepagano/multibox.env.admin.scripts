#!/system/bin/sh

export DIR=`dirname $(dirname $0)`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="80i3arA1IReWYFm2JRLsBp7yrG1cA9EjBdANMkEzuA3Jxy02mbrMFuVhcDa7jxJBjOM91K"

app="www .code"
apkSection="005.0-#######-www-code-"
FileName="005.0"
FileExtension="WebPack"
path="/data/asusbox/.install/02.files"
pathToInstall="/storage/emulated/0/Android/data/asusbox/.www/.code"
DevFolder="/storage/DevMount/GitHUB/asusbox/adm.build/www/.code"
admExport=$(dirname $0)
ExcludeItens="qrcode/qrIP.png-errors.txt"

cmdCheck='versionBinLocal=`/system/bin/busybox head -1 /storage/emulated/0/Android/data/asusbox/.www/.code/version`'
# eval $cmdCheck
versionBinOnline="function exportWwwAssets preenche"

FileList="$GenPackF"
SCRIPT=`realpath $0`
### Tasks ###############################################################################
RsyncGenPackF
obfuscatePHP
compressTargetDir

exportWwwAssets

