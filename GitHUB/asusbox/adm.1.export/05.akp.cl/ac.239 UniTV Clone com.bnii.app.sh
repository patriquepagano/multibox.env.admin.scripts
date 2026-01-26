#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="gOLFpb6UH48EpWLCXPUATEEnznyoUSZ5FQvRsux7C7KQ3Y6q7fUhCrnmuZBhealMgDvQU2"
# app vars
app="com.bnii.app"
fakeName="UniTV (4.14.4)"
apkSection="clones"
apkName="ac.239"
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


# {UniTV} [com.bnii.app] (4.14.4)