####################### DTF Results >>> Wed Dec 31 21:41:29 BRT 1969
apkName="ao.05"
app="acr.browser.barebones"
versionNameOnline="Tue Dec  1 13:23:48 BRST 2020"
SourcePack="/data/asusbox/.install/04.akp.oem/ao.05/DTF/ao.05.DTF"
excludeListPack "/data/asusbox/.install/04.akp.oem/ao.05"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/acr.browser.barebones/Tue Dec  1 13:23:48 BRST 2020" ] ; then
    pm clear acr.browser.barebones
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/acr.browser.barebones-*/lib/arm /data/data/acr.browser.barebones/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/acr.browser.barebones/Tue Dec  1 13:23:48 BRST 2020"
fi
###################################################################################
# config forçada para rodar sempre no boot

