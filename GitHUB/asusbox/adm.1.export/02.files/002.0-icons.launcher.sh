#!/system/bin/sh

export DIR=`dirname $(dirname $0)`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="eO6OX2EHYJVzmX4zUAKpakDuZbByXdpE9oP9xVy68vmIVDzVujIWO6eguftvHa0TuI7poR"

app="icons launcher"
apkSection="002.0-#######-icons.launcher-"
FileName="002.0"
FileExtension="WebPack"
path="/data/asusbox/.install/02.files"
pathToInstall="/storage/emulated/0/Android/data/asusbox/.www/.img.launcher"
DevFolder="/storage/DevMount/GitHUB/asusbox/adm.build/www/.img.launcher"
admExport=$(dirname $0)
ExcludeItens="LICENSE.txt"

cmdCheck='versionBinLocal=`/system/bin/busybox head -1 /storage/emulated/0/Android/data/asusbox/.www/.img.launcher/version`'

FileList="$GenPackF"
SCRIPT=`realpath $0`
### Tasks ###############################################################################
RsyncGenPackF

compressTargetDir

exportWwwAssets

