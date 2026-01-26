#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="QfxJcXCZYo0kxFOCDNky5288cRp30eyfWi1prU6hQe9fE2kH4vzVplBEw1hFh57Qu5vJzi"
# app vars
app="com.super.tela"
fakeName="Vu Player (1.7)"
apkSection="clones"
apkName="ac.237"
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


# {Vu Player} [com.super.tela] (1.7)