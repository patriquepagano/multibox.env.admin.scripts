#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="6sW73WsTmDhvUbGSyQPbmRG3tA2p7s1M11p6cuh5hfN7dZ5dg2oMXkTDadXATIokZiZzJ9"
# app vars
app="iptvsmart.iboxt"
fakeName="DUNA XTP (1.18)"
apkSection="clones"
apkName="ac.229"
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


# {DUNA XTP} [iptvsmart.iboxt] (1.18)