#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="izfLf7WHMiTzQr99NLmSpxZSYT2XuKXiBjnMU1vw1LhbGuS7dhmdysKOxycbBrP4l8Hope"
# app vars
app="com.ibostore.meplayerib4k"
fakeName="MediaPlayerIbo (229.6)"
apkSection="clones"
apkName="ac.205"
path="/data/asusbox/.install/05.akp.cl"
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
compressAPKDataFull

exportDTF
exportAKP

RenameExportDataFile

# {MediaPlayerIbo} [com.ibostore.meplayerib4k] (229.6)c



