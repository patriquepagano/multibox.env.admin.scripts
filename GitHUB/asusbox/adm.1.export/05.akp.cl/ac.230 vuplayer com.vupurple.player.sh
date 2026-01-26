#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="D4ZrHN0Iab2RbDgewMgAEZAJIoBLv455GRk68dqF9eAKc7PPEowYeGteTyXWpgxV7zO9fF"
# app vars
app="com.vupurple.player"
fakeName="VU Player Pro (1.6)"
apkSection="clones"
apkName="ac.230"
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


# 34) {VU Player Pro} [com.vupurple.player] (1.6)