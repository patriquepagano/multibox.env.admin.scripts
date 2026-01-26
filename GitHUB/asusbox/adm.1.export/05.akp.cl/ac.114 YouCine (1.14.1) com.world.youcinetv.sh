#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="TMSBaOtRjWNAHPktr7RDdt38kcxMmNfDT20WcbIIG2ztSwnUp2VPw0GCEIhbl387kDzGtu"
# app vars
app="com.world.youcinetv"
fakeName="YouCine (1.15.1)"
apkSection="clones"
apkName="ac.114"
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

# {YouCine} [com.world.youcinetv] (1.7.5)
# input text "pr0burn@hotmail.com"
# input text "707070py"
# pm clear com.world.youcinetv
# input text "pr0burn@hotmail.com"
# input text "558800py"