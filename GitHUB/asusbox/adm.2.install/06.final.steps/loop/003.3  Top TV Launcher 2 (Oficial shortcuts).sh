####################### DTF Results >>> Fri Jan 23 18:44:58 UTC___ 2026
Senha7z="a5sd76f54a7s6f4as76d54f675sda4f67sd5a4f67sa5d4f67asd4f76sad4fs6da"
apkName="akpb.003"
app="dxidev.toptvlauncher2"
fakeName="Top TV Launcher 2 (1.39)"
versionNameOnline="Fri Jan 23 18:44:58 UTC___ 2026"
SourcePack="/data/asusbox/.install/03.akp.base/akpb.003/DTF/akpb.003.DTF"
excludeListPack "/data/asusbox/.install/03.akp.base/akpb.003"
# Verifica se os arquivos locais estao atualizados
#CheckDownloadFiles
# se o data estiver limpo ou sem arquivo set vai aplicar
if [ ! -f "/data/data/dxidev.toptvlauncher2/Fri Jan 23 18:44:58 UTC___ 2026" ] ; then
    pm disable dxidev.toptvlauncher2
    pm clear dxidev.toptvlauncher2
    extractDTFSplitted
    ###################################################################################
    # manualDTFfix
    
    ###################################################################################
    # seta as permissões de user da pasta
    FixPerms
    ###################################################################################
    # atualiza o symlink das libs em caso de atualização de apk
    ln -sf /data/app/dxidev.toptvlauncher2-*/lib/arm /data/data/dxidev.toptvlauncher2/lib
    ###################################################################################
    # permissoes do app
    AppGrantLoop="android.permission.READ_EXTERNAL_STORAGE"
    AppGrant
    ###################################################################################
    # manualDTFposPerms nos arquivos após as permissões
    
    ###################################################################################
    # cria o marcador para não rodar isto sempre
    date > "/data/data/dxidev.toptvlauncher2/Fri Jan 23 18:44:58 UTC___ 2026"
    pm enable dxidev.toptvlauncher2
    # fix unico para a launcher, em caso de update chama para a frente do cliente
    if [ "dxidev.toptvlauncher2" == "dxidev.toptvlauncher2" ]; then
        # força o uso da launcher official
        cmd package set-home-activity "dxidev.toptvlauncher2/dxidev.toptvlauncher2.HomeActivity"
    fi
fi
###################################################################################
# config forçada para rodar sempre no boot

