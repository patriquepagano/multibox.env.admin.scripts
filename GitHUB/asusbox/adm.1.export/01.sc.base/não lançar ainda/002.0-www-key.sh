#!/system/bin/sh

export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="YdIoUZQoTM0JHUd2nqc6Z0P0MbeHuSDXY9IdWAGthhzu6CAzbgebUTR8rojJ9CJ8QcZvLT"

app="input serial"
apkSection="002.0-#######-www-key-"
FileName="002.0"
FileExtension="WebPack"
path="/data/asusbox/.install/01.sc.base"
pathToInstall="/data/asusbox/.sc/www"
DevFolder="/storage/DevMount/GitHUB/asusbox/adm.build/www_key"
admExport=$(dirname "$0")
ExcludeItens="nada"

cmdCheck='versionBinLocal=`/system/bin/busybox head -1 /data/asusbox/.sc/www/version`'
# eval $cmdCheck
versionBinOnline="function exportWwwAssets preenche"

FileList="$GenPackF"
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
RsyncGenPackF
obfuscatePHP
compressTargetDir

exportWwwAssets


