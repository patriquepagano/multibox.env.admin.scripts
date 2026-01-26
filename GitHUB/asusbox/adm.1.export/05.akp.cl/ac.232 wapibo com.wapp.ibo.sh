#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="mlguxqDfoy9yWmONZMsfsYZP0fReNJ1JkzKtt7OrIu8WwiY7OenuUTGzgM11mKyxcUneOm"
# app vars
app="com.wapp.ibo"
fakeName="Wapp IBO (3.9)"
apkSection="clones"
apkName="ac.232"
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


# {Wapp IBO} [com.wapp.ibo] (3.9)