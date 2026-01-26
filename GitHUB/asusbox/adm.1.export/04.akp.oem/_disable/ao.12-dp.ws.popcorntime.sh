#!/system/bin/sh
#
export DIR=`dirname $(dirname $0)`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z=a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da
# app vars
app="dp.ws.popcorntime"
fakeName="pipoca"
apkSection="oem"
apkName="ao.12"
path="/data/asusbox/.install/04.akp.oem"
admExport=$(dirname $0)
# app configs
LauncherIntegrated="no"
manualAKPfix=""
# data configs
clearAppDataOnBoot="no"
ConfigDataVersion="1.0.0"
manualDTFfix=""
AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
SCRIPT=`realpath $0`
### Tasks ###############################################################################
# compressAPK
# compressAPKDataFull

#exportDTF
exportAKP


# app do icone da pipoca
# a ideia deste app é listar filmes e series para download na box
# vod e series ok
# config forçada é configurar o app apenas e ativar o hardware decoder



