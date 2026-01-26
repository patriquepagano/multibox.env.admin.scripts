#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="11J2skLJS3bUEvr5ZOabq49CW2H4Evu7lw1nYr9343IH5VySJtBCosGeUF1XTkeelUmBLf"
# app vars
app="tv.pluto.android"
fakeName="Pluto TV"
apkSection="oem"
apkName="ao.10"
path="/data/asusbox/.install/04.akp.oem"
admExport=$(dirname "$0")
# app configs
LauncherIntegrated="no"
manualAKPfix=""
# data configs
clearAppDataOnBoot="no"
ConfigDataVersion="1.0.0"
manualDTFfix=""
AppGrantLoop=""
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
compressAPK

exportAKP

# # envia via google provisóriamente
# AKPouDTF="AKP"
# rcloneUpload




