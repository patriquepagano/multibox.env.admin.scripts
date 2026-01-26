#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="zNNxizEiOkfX99z2ngbs7gETcvco50MUX6WTJk97Vtc5EJSghAakzFf5QIffwMj7WdmPEo"
# app vars
app="de.robv.android.xposed.installer"
apkSection="005.0-#######-$app-"
apkName="005.0"
path="/data/asusbox/.install/01.sc.base"
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
# compressAPK
# compressAPKDataFull

exportDTF

exportAKP

