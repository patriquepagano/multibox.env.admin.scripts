#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="rR3XU99p089AQbre43naEuVYBNfrdIhgndyquV7n0CXoRK0PWL2w4HFcUoVAEtYMbnGHLF"
# app vars
app="com.amazon.amazonvideo.livingroom"
fakeName="Prime Video (6.17.0+v15.1.0.291-armv7a)"
apkSection="oem"
apkName="ao.24"
path="/data/asusbox/.install/04.akp.oem"
admExport=$(dirname "$0")
# app configs
LauncherIntegrated="no"
manualAKPfix=""
# data configs
clearAppDataOnBoot="no"
ConfigDataVersion="1.0.0"
manualDTFfix=""
manualDTFfixForced=""
AppGrantLoop=""
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
compressAPK

exportAKP

#   22) {Prime Video} [com.amazon.amazonvideo.livingroom] (6.17.0+v15.1.0.291-armv7a)



