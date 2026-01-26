#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="g8idd83cNu4jnMzJZm83eVPAjr1FJ8dhxd1ZX8n9Jyb49mSQ1QiMSU1MmiBnXiiBSIE7ck"
# app vars
app="io.wareztv.android.pro"
fakeName="WPlay Pro (4.2.8)"
apkSection="clones"
apkName="ac.235"
path="/data/asusbox/.install/05.akp.cl"
admExport=$(dirname "$0")
# app configs
LauncherIntegrated="no"
manualAKPfix=""
# data configs
clearAppDataOnBoot="no"
ConfigDataVersion="1.0.0"
manualDTFfix=""
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
compressAPK
compressAPKDataFull

exportDTF
exportAKP

RenameExportDataFile


# {WPlay Pro} [io.wareztv.android.pro] (4.2.8)