#!/system/bin/sh

export DIR=`dirname $(dirname $0)`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="B8b32QrrD2aqsi5FTlesvvJNejGnYCmRpBcCobMZsYzgcUTmRwWgpguKlW2EeUfON79DoY"
# Scripts
app="boot base"
apkSection="001.0-#######-sc-boot-"
FileName="001.0"
FileExtension="SC"
path="/data/asusbox/.install/01.sc.base"
pathToInstall="/data/asusbox/.sc/boot"
DevFolder="/storage/DevMount/GitHUB/asusbox/adm.build/boot"
admExport=$(dirname $0)

cmdCheck='versionBinLocal=`/data/asusbox/.sc/boot/hash-check.sh`'
versionBinOnline="594cfdc3dc96a60e1bd4b8e0662d97f5"

SCRIPT=`realpath $0`
# gera novo pack sem comentarios novo hash versionBinOnline
obfuscateFolder
# ### Tasks ###############################################################################
# Atenção sempre quando comprimir novo pack sera feito upload
# o novo pack tem o crc diferente sempre a cada versão
# renomear arquivos ou comentar não altera o crc do pack
# o update do arquivo no google drive é IMEDIATO! POIS O GOOGLEID NÃO MUDA
compressScripts
rm -rf /data/local/tmp/GenPack

exportVarsScripts



