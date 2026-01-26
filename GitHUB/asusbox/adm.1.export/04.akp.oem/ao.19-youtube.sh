#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="QYnjbpxnC01oaEeQn1aNSujr92lgKvjk4She815JHMCT9g21E4UoQ6fWCiu2PV540ueZvi"
# app vars
app="com.google.android.youtube.tv"
fakeName="YouTube"
apkSection="oem"
apkName="ao.19"
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
#compressAPK

exportAKP


# {YouTube} [com.google.android.youtube.tv] (2.07.02)



