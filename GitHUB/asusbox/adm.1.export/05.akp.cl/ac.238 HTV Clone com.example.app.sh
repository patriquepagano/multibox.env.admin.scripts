#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="AmxPoQHfBRrttx7smeZIdm4HjBSYI3Q3VQAMG7nzgqytIvcDcX9u0m7o15TgN5hZRexOin"
# app vars
app="com.example.app"
fakeName="HTV (5.40.0)"
apkSection="clones"
apkName="ac.238"
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


# {HTV} [com.example.app] (5.40.0)