#!/system/bin/sh

export DIR=`dirname $(dirname $0)`
source "$DIR/_functions/generate.sh"
source "$DIR/_functions/allFunctions.sh"

# comprimir
Senha7z="6Is9vIzqmijSOzj2MrpUlLYHigslYbTBRBbBllEW7zI5nmudY5vFi3yhvNBnbRkda1dF6L"
# Scripts
app="sc-online"
apkSection="003.0-#######-sc-online-mode-"
FileName="003.0"
FileExtension="SC"
path="/data/asusbox/.install/02.files"
pathToInstall="/data/asusbox/.sc/OnLine"
DevFolder="/storage/DevMount/GitHUB/asusbox/adm.build/OnLine"
admExport=$(dirname $0)

cmdCheck='versionBinLocal=`/data/asusbox/.sc/OnLine/hash-check.sh`'
versionBinOnline="ce3adb882d8cdcbb249045d660dafcd3"

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


