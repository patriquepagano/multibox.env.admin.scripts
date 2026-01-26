#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="UNsHNp8HzuN0wcSgiU9oBM3usYtBAFA9vtNz3cDQ1pmkXdErexsX0lwdig7crquYFjM1dI"
# app vars
app="br.com.kerhkhd"
fakeName="P2Mais v5.9.1 (5.9.1)"
apkSection="clones"
apkName="ac.201"
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

# {P2Mais v5.9.1} [br.com.kerhkhd] (5.9.1)
# input text "439212682461"


