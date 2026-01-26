####################### DTF Results >>> Thu Sep 30 17:01:17 BRT 2021
Senha7z="a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da"
apkName="ao.06"
app="com.mixplorer"
versionNameOnline="Tue Nov 24 22:16:05 BRST 2020"
SourcePack="/data/asusbox/.install/04.akp.oem/ao.06/DTF/ao.06.DTF"
excludeListPack "/data/asusbox/.install/04.akp.oem/ao.06"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.mixplorer/Tue Nov 24 22:16:05 BRST 2020" ] ; then
    pm clear com.mixplorer
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.mixplorer-*/lib/arm /data/data/com.mixplorer/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.mixplorer/Tue Nov 24 22:16:05 BRST 2020"
fi
###################################################################################
# config forçada para rodar sempre no boot

