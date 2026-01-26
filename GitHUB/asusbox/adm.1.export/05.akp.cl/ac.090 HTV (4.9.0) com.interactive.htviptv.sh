#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="FvdONx3132RvOEB2p9BCu3q1h4iW3728Why969f8hFyK7kcjOHxY6V4QEW3KhGLLKTRttX"
# app vars
app="com.interactive.htviptv"
fakeName="HTV (4.9.0)"
apkSection="clones"
apkName="ac.090"
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

# htv pede acesso a arquivos

#    input text 'pr0burn@hotmail.com' 
#    input text '558800py'



