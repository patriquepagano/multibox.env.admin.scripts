#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="UefYqIr2RmcpgnG79rSulwc1cH14t7INdsY4ilsvJYafvzZsadzt4899V1Q6My9pqAVBJF"
# app vars
app="com.chsz.efile.alphaplay"
fakeName="Alphaplay (a5.2.1-20240619)"
apkSection="clones"
apkName="ac.179"
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

# Alphaplay_a5.2.1.apk = {Alphaplay} [com.chsz.efile.alphaplay] (a5.2.1-20240619)
