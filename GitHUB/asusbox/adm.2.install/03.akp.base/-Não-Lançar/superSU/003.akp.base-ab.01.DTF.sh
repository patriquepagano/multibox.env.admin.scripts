####################### DTF Results >>> Fri Nov 13 11:02:25 BRT 2020
DataBankTMP="
/data/asusbox/.install/03.akp.base/ab.01/DTF/;ab.01.DTF.001;90025665591e83377034ff95325f7a6f;1AZyCHHg-OofFT1g63CdAXvyScePeIGuW;1wYuWTsKzXjOiPygbEgUnQvhSpthAkRVW;1-x9YB86yfuyfAN1xwWpC4mZxECsJSc-O;15gP3kmQ_WQlQUCsyX5K7lQUfz1TcFazC;1agBAeMd6AORPk52NBtYuVTXf862tLc7a;1JmTmWeXF8YSZRYm2K2kzRQjUQHrSeJSt;1eKLiiMrJOSV8s-lsN6yqvbLUJyqidXfS
"
# Check e download Files, if o torrent já não tiver feito
CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f /data/data/eu.chainfire.supersu/1.0.0 ] ; then
pm clear eu.chainfire.supersu
extractDTFSplitted
# manual config nos arquivos

# seta as permissões de user da pasta
FixPerms
# atualiza o symlink das libs em caso de atualização de apk
ln -sf /data/app/eu.chainfire.supersu-*/lib/arm /data/data/eu.chainfire.supersu/lib
# permissoes do app
AppGrantLoop=""
AppGrant
# cria o marcador para não rodar isto sempre
date > /data/data/eu.chainfire.supersu/1.0.0
fi
# config forçada para rodar sempre no boot

