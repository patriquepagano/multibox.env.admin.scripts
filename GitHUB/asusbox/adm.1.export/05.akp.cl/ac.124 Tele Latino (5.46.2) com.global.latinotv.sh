#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="lPqPRo36lYXDT9F2AZutH8gYce38ygrMuVAZDM4R4szhxN6r68fdH4T51Q5PbyKXYpcuob"
# app vars
app="com.global.latinotv"
fakeName="Tele Latino (5.46.5)"
apkSection="clones"
apkName="ac.124"
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

# {Tele Latino} [com.global.latinotv] (5.42.0)
# Usuário e senha 
# 6gnpnh
# 88888888
