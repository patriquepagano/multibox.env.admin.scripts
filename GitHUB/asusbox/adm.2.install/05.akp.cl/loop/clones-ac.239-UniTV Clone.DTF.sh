####################### DTF Results >>> Fri Jan 23 18:14:55 UTC___ 2026
Senha7z="gOLFpb6UH48EpWLCXPUATEEnznyoUSZ5FQvRsux7C7KQ3Y6q7fUhCrnmuZBhealMgDvQU2"
apkName="ac.239"
app="com.bnii.app"
fakeName="UniTV (4.14.4)"
versionNameOnline="Fri Jan 23 18:14:55 UTC___ 2026"
SourcePack="/data/asusbox/.install/05.akp.cl/ac.239/DTF/ac.239.DTF"
excludeListPack "/data/asusbox/.install/05.akp.cl/ac.239"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/com.bnii.app/Fri Jan 23 18:14:55 UTC___ 2026" ] ; then
    pm disable com.bnii.app
    pm clear com.bnii.app
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/com.bnii.app-*/lib/arm /data/data/com.bnii.app/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/com.bnii.app/Fri Jan 23 18:14:55 UTC___ 2026"
    pm enable com.bnii.app
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "com.bnii.app" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

