#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="lgCIglqBw75gJzYxFMLcJHIkZsd4MEHUskmNZJgJcRh7MGSfJ7HXM8u3R6plGrgaGsMtxy"
# app vars
app="com.new2tourosat.app"
fakeName="Tourolive T1 (2.4.4)"
apkSection="clones"
apkName="ac.223"
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


# {Tourolive T1} [com.new2tourosat.app] (2.4.4)