#!/system/bin/sh

export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# Binário
app="p2pFile"
apkSection="004.0-#######-$app-"
FileName="p2pSeed"
FilePerms="700"
FileCmd=""
NeedReboot=""
pathToInstall='/data/asusbox/.install.torrent'
admExport=$(dirname "$0")

cmdCheck='versionBinLocal=`/system/bin/busybox cat "/data/asusbox/.install.torrent" | /system/bin/busybox base64`'

DevScript="/storage/DevMount/GitHUB/asusbox/adm.2.install/.install.torrent"
versionBinLocal=`/system/bin/busybox cat "$DevScript" | /system/bin/busybox base64`

versionBinOnline="$versionBinLocal"

### Tasks ###############################################################################
exportBase64
