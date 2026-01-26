#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="7I83qKeLMLPqQcmMnAfabQ0xi26IccaKSvTqWBv2cpm5IXJQuvenN2T31SvLlgUe83nSPK"
# app vars
app="io.gh.reisxd.tizentube.fortaleza"
fakeName="YouTube Premium ®FOR (: Fortaleza EC ®)"
apkSection="clones"
apkName="ac.209"
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

# {YouTube Premium ®FOR} [io.gh.reisxd.tizentube.fortaleza] (: Fortaleza EC ®)



