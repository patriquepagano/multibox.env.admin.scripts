#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="Qzh5LTWj9ZxLjBrbEuJf7jhvfoeqisPTsGrvngTkdrsEyPsjFkfxVfr1luj5zu2pQukVhP"
# app vars
app="com.netflix.mediaclient"
fakeName="Netflix (7.120.6 build 63 35594)"
apkSection="oem"
apkName="ao.22"
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

# {Netflix} [com.netflix.mediaclient] (7.120.6 build 63 35594)



