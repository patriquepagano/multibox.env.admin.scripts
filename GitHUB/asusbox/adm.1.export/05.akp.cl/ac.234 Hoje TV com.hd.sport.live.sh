#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="VnqUp6KJlnTOZZbtKpBnWe55LRyJtTiG0kVSJKVXueFaTVruso0e5CcHABH9TXSRJKCCCE"
# app vars
app="com.hd.sport.live"
fakeName="Hoje TV (2.2.188)"
apkSection="clones"
apkName="ac.234"
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


# {Hoje TV} [com.hd.sport.live] (2.2.188)