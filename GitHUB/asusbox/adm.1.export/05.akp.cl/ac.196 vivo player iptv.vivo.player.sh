#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="fvPVr6r5ljfy2cLjBPkCYVzEkkF91ujkNVqr5XDL4seZqmiAOuoDgdu4qmxv5NBEZb4Jn2"
# app vars
app="iptv.vivo.player"
fakeName="Vivo Player (3.3.6)"
apkSection="clones"
apkName="ac.196"
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
compressAPKDataFull

exportDTF
exportAKP

RenameExportDataFile

# {Vivo Player} [iptv.vivo.player] (3.3.6)

