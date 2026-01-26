#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="d2hk4ObSxbXgMffjfyNzfziQK3lTFWlG9NjTRRQKoe5JDL1UfZne26vPazusKTdRRV5GQP"
# app vars
app="com.integration.unitvsiptv"
fakeName="UniTV Free (5.3.1)"
apkSection="clones"
apkName="ac.222"
path="/data/asusbox/.install/05.akp.cl"
admExport=$(dirname "$0")
# app configs
LauncherIntegrated="no"
manualAKPfix=""
# data configs
clearAppDataOnBoot="no"
ConfigDataVersion="1.0.0"
manualDTFfix="
rm /storage/emulated/0/.config
rm /storage/emulated/0/.properties
echo -n '#personal info
#Sat Aug 30 22:49:36 GMT-03:00 2025
key_device_id_unitvfree=443141686b59376e573358313356714b66417a3573413d3d
key_sn_token_unitvfree=546e4753625874497347715162776969354c4f65626a6c3838746d794f514134
' > /storage/emulated/0/.config
"
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
compressAPK
compressAPKDataFull

exportDTF
exportAKP

RenameExportDataFile


# {UniTV Free} [com.integration.unitvsiptv] (5.3.1)