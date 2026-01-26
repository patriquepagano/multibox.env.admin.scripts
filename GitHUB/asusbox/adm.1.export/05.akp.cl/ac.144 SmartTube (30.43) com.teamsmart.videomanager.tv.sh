#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="vqyxooRuMWUVBqa6IXJ6MsiT4uStWpTOExOwTETl0GEIDOt6sAx5aPJ7XNXE1Q7OGHpeHo"
# app vars
app="com.teamsmart.videomanager.tv"
fakeName="SmartTube (30.48)"
apkSection="clones"
apkName="ac.144"
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
#compressAPKDataFull

#exportDTF
exportAKP


RenameExportDataFile
# {SmartTube} [com.teamsmart.videomanager.tv] (14.16)



