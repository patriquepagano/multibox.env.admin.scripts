####################### DTF Results >>> Wed Dec 31 21:14:10 BRT 1969
apkName="003.0"
app="eu.chainfire.supersu"
versionNameOnline="Wed Dec 31 21:13:45 BRT 1969"
SourcePack="/data/asusbox/.install/01.sc.base/003.0/DTF/003.0.DTF"
excludeListPack "/data/asusbox/.install/01.sc.base/003.0"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/eu.chainfire.supersu/Wed Dec 31 21:13:45 BRT 1969" ] ; then
    pm clear eu.chainfire.supersu
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/eu.chainfire.supersu-*/lib/arm /data/data/eu.chainfire.supersu/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop=""
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/eu.chainfire.supersu/Wed Dec 31 21:13:45 BRT 1969"
fi
###################################################################################
# config forçada para rodar sempre no boot

