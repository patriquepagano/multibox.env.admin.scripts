#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="dnllyzajjcpXpnRzQYwbZDhGsQ3QzX4eXndrCLRZ7b3IIFWqxcxHFJ2kq9TOYCtHUC6swh"
# app vars
app="com.flextv.livestore"
fakeName="Ibo Player Pro (3.5)"
apkSection="clones"
apkName="ac.236"
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


# {Ibo Player Pro} [com.flextv.livestore] (3.5)