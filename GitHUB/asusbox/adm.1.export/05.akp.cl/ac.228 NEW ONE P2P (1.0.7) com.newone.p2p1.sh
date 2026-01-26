#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="7uXfwfCjTheIecYJQFl2bTAYfhgYhD9jAH7uT06IDaTPOgzUaVAyDtgTQAOc8r9a9C7IDb"
# app vars
app="com.newone.p2p1"
fakeName="NEW ONE P2P (1.0.7)"
apkSection="clones"
apkName="ac.228"
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


# {NEW ONE P2P} [com.newone.p2p1] (1.0.5)
# /data/data/com.newone.p2p1/files/MeuApp.apk