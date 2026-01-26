#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="JstvhQV3ci9ydLpHK4kiUYj0yWDnOAjDmV3wvvErHytAQJJbCoBtnpuXgvz8tzhF2wu4YD"
# app vars
app="com.android.mgstv"
fakeName="MAGIS (5.0.4)"
apkSection="clones"
apkName="ac.148"
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
#compressAPKDataFull

#exportDTF
exportAKP


RenameExportDataFile
# {MAGIS} [com.android.mgstv] (4.24.1) pede sdcard


