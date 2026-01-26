#!/system/bin/sh
source /data/.vars
source "/data/asusbox/adm.1.export/_functions/generate.sh"
source "/data/asusbox/adm.1.export/_functions/allFunctions.sh"

# Binário
app="vars"
apkSection="005.0-#######-$app-"
FileName="strings"
FilePerms="600"
FileCmd=""
NeedReboot=""
pathToInstall="/data/.vars"
admExport=$(dirname $0)

cmdCheck='versionBinLocal=`/system/bin/busybox cat "/data/.vars" | /system/bin/busybox base64`'

DevScript="/data/asusbox/adm.build/boot-files/.vars/boot/.vars.sh"
versionBinLocal=`/system/bin/busybox cat "$DevScript" | /system/bin/busybox base64`

versionBinOnline="$versionBinLocal"

### Tasks ###############################################################################
exportBase64

