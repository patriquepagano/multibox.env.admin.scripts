#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="fZhbrZLX0wGiRKNtLW3Bqti1qeB2sNym9mgnpDCFXhVSB48DAxzZ96ZvedNyKbSNwV4XMk"
# app vars
app="com.digitizercommunity.loontv"
fakeName="Loon (2.0.95)"
apkSection="clones"
apkName="ac.170"
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

#   loon_tv1.apk = {Loon} [com.digitizercommunity.loontv] (2.0.95)


