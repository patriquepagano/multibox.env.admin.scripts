#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="kDYVBKspWUmbqTfLGlQWIsNKVANQgeYBNAmAuUiDVltGOoaxib1YPGyM6YeGgCV24ttRmO"
# app vars
app="com.disney.disneyplus"
fakeName="Disney+ (4.15.0+rc3-2025.09.04)"
apkSection="oem"
apkName="ao.23"
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

# {Disney+} [com.disney.disneyplus] (4.15.0+rc3-2025.09.04)



