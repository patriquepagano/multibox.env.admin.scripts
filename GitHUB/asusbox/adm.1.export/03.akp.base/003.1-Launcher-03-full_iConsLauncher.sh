#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
# app vars
app="dxidev.toptvlauncher2"
fakeName="Top TV Launcher 2 (1.39)"
apkSection="base"
apkName="akpb.003"
path="/data/asusbox/.install/03.akp.base"
admExport=$(dirname "$0")
# app configs
LauncherIntegrated="yes"
manualAKPfix=""
# data configs
clearAppDataOnBoot="no"
ConfigDataVersion="1.0.0"
manualDTFfix=""
manualDTFfixForced=""
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
compressAPKDataFull

exportDTF

