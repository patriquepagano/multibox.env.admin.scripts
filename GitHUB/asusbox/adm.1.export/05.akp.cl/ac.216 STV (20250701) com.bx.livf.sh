#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="W3bzfo8LNliD3hA6JBhCmzGb49V3MSCO7QuMmfKs4TXeggr17egF1Z8SqPC8FwGQ3tmQk7"
# app vars
app="com.bx.livf"
fakeName="STV (20250701)"
apkSection="clones"
apkName="ac.216"
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
#compressAPK
compressAPKDataFull

exportDTF
#exportAKP

RenameExportDataFile

# {STV} [com.bx.livf] (20250701)


