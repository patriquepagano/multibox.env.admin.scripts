#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="wQZFLXVNYFCamFHtrCR9arhB46BybXIE47tGOn3uUnXGDzQRRcRQA0kj3yAIH9vvx31Igy"
# app vars
app="com.exploudapps.maxnettv"
fakeName="Max Net TV (12.3)"
apkSection="clones"
apkName="ac.225"
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


# {Max Net TV} [com.exploudapps.maxnettv] (12.3)