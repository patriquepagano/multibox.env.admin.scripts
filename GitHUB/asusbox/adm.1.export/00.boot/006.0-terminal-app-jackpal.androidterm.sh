#!/system/bin/sh
#
export DIR=`dirname $(dirname "$0")`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="TlVoWbhybXuTUfRe3yBc8xEEG390CDLtbEFZ4CVTuMnMPxY2S3WIuse0CUFMwVUicAuucB"
# app vars
app="jackpal.androidterm"
apkSection="006.0-#######-$app-"
apkName="006.0"
path="/data/asusbox/.install/00.boot"
admExport=$(dirname "$0")
# app configs
LauncherIntegrated="no"
manualAKPfix=""
# data configs
clearAppDataOnBoot="no"
ConfigDataVersion="1.0.0"
manualDTFfix=""
manualDTFfixForced=""
AppGrantLoop=""
SCRIPT=`realpath "$0"`
### Tasks ###############################################################################
# compressAPK
# compressAPKDataFull

#exportDTF
exportAKP

# usar um app de terminal:

# problemas:
# - rempactora o firmware removendo o .pin (o update sobreescreve)
# - usar um pack no recovery para reinstall do root ( o update sobreescreve o.pin e o data do superSU)

# beneficios:
# + interface simples com o cliente fazer o input do serial
# + comunicação rapida com o cliente!
# + usar html na box para informar tipo um manual e o terminal digitando numeros para selecionar as funções

